import 'dart:math';
import 'package:dicey/controllers/dice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../db/database.dart';

const int maxDie = 6;

class Dice extends ChangeNotifier {
  late final ProviderRef ref;
  int diceOne = 1;
  int diceTwo = 1;
  int numOfThrows = 0;
  bool equalDist = false;

  List<int> sumStatistics = List.filled((2 * maxDie) - 1, 0);
  List<List<int>> dieStatistics =
      List.generate(maxDie + 1, (i) => List<int>.filled(maxDie + 1, 0));

  final DiceHistoryNotifier diceHistory;

  Dice(this.diceHistory);

  Future<void> saveStatistics() async {
    final Database db = await DatabaseProvider().database;

    // Clear existing statistics from the database
    await db.delete('sum_stats');
    await db.delete('throw_stats');
    await db.delete('matrix_stats');

    // Save the sumStatistics
    for (int i = 0; i < sumStatistics.length; i++) {
      await db.insert('sum_stats', {
        'sumIndex': i,
        'count': sumStatistics[i],
      });
    }

    await db.insert('throw_stats', {
      'numOfThrows': numOfThrows,
    });

    for (int i = 0; i < dieStatistics.length; i++) {
      for (int j = 0; j < dieStatistics[i].length; j++) {
        await db.insert('matrix_stats', {
          'row': i,
          'col': j,
          'value': dieStatistics[i][j],
        });
      }
    }
  }

  Future<void> loadStatistics() async {
    final Database db = await DatabaseProvider().database;

    List<Map<String, dynamic>> results = await db.query('sum_stats');
    if (results.isNotEmpty) {
      for (var row in results) {
        final int sumIndex = row['sumIndex'];
        final int count = row['count'];
        sumStatistics[sumIndex] = count;
      }
    }

    List<Map<String, dynamic>> throwResults = await db.query('throw_stats');
    if (throwResults.isNotEmpty) {
      numOfThrows = throwResults.first['numOfThrows'];
    }

    List<Map<String, dynamic>> matrixResults = await db.query('matrix_stats');
    if (matrixResults.isNotEmpty) {
      for (var row in matrixResults) {
        int rowIndex = row['row'];
        int columnIndex = row['col'];
        int value = row['value'];
        dieStatistics[rowIndex][columnIndex] = value;
      }
    }
  }

  void throwDice(bool equalD) async {
    Map<String, dynamic> previousState = captureState();
    if (equalD) {
      final possibleSums =
          List.generate((2 * maxDie) - 1, (index) => index + 2);
      // random selection of a sum
      final selectedSum = possibleSums[Random().nextInt((2 * maxDie) - 1)];

      // List of dice combinations for a given sum value
      final combiSum = <List<int>>[];
      for (int i = 1; i <= maxDie; i++) {
        for (int j = 1; j <= maxDie; j++) {
          if (i + j == selectedSum) {
            // add all possible combinations for a given sum onto a temporary list
            combiSum.add([i, j]);
          }
        }
      }
      var temp = combiSum[Random().nextInt(combiSum.length)];
      // use the list to randomly select a die combination for the randomly selected sum.
      diceOne = temp[0];
      diceTwo = temp[1];
    } else {
      diceOne = Random().nextInt(maxDie) + 1;
      diceTwo = Random().nextInt(maxDie) + 1;
    }

    int sum = diceOne + diceTwo;
    numOfThrows++;
    sumStatistics[sum - 2] += 1;
    await saveStatistics();
    dieStatistics[diceOne - 1][diceTwo - 1]++;
    diceHistory.add(previousState);
    notifyListeners();
  }

  // make 1000 die throws
  void throwThousand(bool equalD) async {
    Map<String, dynamic> previousState = captureState();
    for (int i = 0; i < 1000; i++) {
      if (equalD) {
        final possibleSums =
            List.generate((2 * maxDie) - 1, (index) => index + 2);
        // random selection of a sum
        final selectedSum = possibleSums[Random().nextInt((2 * maxDie) - 1)];

        // List of dice combinations for a given sum value
        final combiSum = <List<int>>[];
        for (int i = 1; i <= maxDie; i++) {
          for (int j = 1; j <= maxDie; j++) {
            if (i + j == selectedSum) {
              // add all possible combinations for a given sum onto a temporary list
              combiSum.add([i, j]);
            }
          }
        }
        var temp = combiSum[Random().nextInt(combiSum.length)];
        // use the list to randomly select a die combination for the randomly selected sum.
        diceOne = temp[0];
        diceTwo = temp[1];
      } else {
        diceOne = Random().nextInt(maxDie) + 1;
        diceTwo = Random().nextInt(maxDie) + 1;
      }

      int sum = diceOne + diceTwo;
      numOfThrows++;
      sumStatistics[sum - 2] += 1;
      dieStatistics[diceOne - 1][diceTwo - 1]++;
    }
    await saveStatistics();
    diceHistory.add(previousState);
    notifyListeners();
  }

  void enableEqualDist(bool equalD) {
    Map<String, dynamic> previousState = captureState();
    equalDist = equalD;
    diceHistory.add(previousState);
    notifyListeners();
  }

  void resetStatistics() async {
    Map<String, dynamic> previousState = captureState();
    numOfThrows = 0;
    diceOne = 1;
    diceTwo = 1;
    sumStatistics = List.filled((2 * maxDie) - 1, 0);
    dieStatistics =
        List.generate(maxDie + 1, (i) => List<int>.filled(maxDie + 1, 0));
    await saveStatistics();
    diceHistory.add(previousState);
    notifyListeners();
  }

  Map<String, dynamic> captureState() {
    return {
      'diceOne': diceOne,
      'diceTwo': diceTwo,
      'numOfThrows': numOfThrows,
      'equalDist': equalDist,
      'sumStatistics': List<int>.from(sumStatistics),
      'dieStatistics': List<List<int>>.from(
        dieStatistics.map((list) => List<int>.from(list)),
      ),
    };
  }

  void restoreState(Map<String, dynamic> state) {
    if (state.isNotEmpty) {
      diceOne = state['diceOne'] ?? 1;
      diceTwo = state['diceTwo'] ?? 1;
      numOfThrows = state['numOfThrows'] ?? 0;
      equalDist = state['equalDist'] ?? false;
      sumStatistics = List<int>.from(state['sumStatistics'] ?? []);
      dieStatistics = List<List<int>>.from(
        state['dieStatistics']
                ?.map<List<int>>(
                  (list) => List<int>.from(list),
                )
                ?.toList() ??
            [],
      );
      notifyListeners();
    }
  }
}
