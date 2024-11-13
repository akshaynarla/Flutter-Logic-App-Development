import 'dart:math';
import 'package:dicey_navigation/controllers/dice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void throwDice(bool equalD) {
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
    dieStatistics[diceOne - 1][diceTwo - 1]++;
    diceHistory.add(previousState);
    notifyListeners();
  }

  // make 1000 die throws
  void throwThousand(bool equalD) {
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
    // debugPrint('$previousState');
    diceHistory.add(previousState);
    notifyListeners();
  }

  void enableEqualDist(bool equalD) {
    Map<String, dynamic> previousState = captureState();
    equalDist = equalD;
    diceHistory.add(previousState);
    notifyListeners();
  }

  void resetStatistics() {
    Map<String, dynamic> previousState = captureState();
    numOfThrows = 0;
    sumStatistics = List.filled((2 * maxDie) - 1, 0);
    dieStatistics =
        List.generate(maxDie + 1, (i) => List<int>.filled(maxDie + 1, 0));
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
