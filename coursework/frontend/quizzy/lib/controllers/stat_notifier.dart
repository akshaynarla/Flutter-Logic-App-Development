import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/quiz/quiz.dart';
import 'package:quizzy/quiz/quiz_api.dart';
import 'package:quizzy/database/quiz_db.dart';

// fetches data from server and stores in sqflite database
// both normal and timed mode stats will be fetched together
class UserStatisticsNotifier extends StateNotifier<UserStatistics?> {
  UserStatisticsNotifier() : super(null);

  Future<void> fetchUserStatistics() async {
    try {
      final stats = await fetchStats();
      state = stats;
      // Saving the fetched data to local database for persistence
      if (stats.normalModeStats != null) {
        await QuizDatabaseProvider.instance.saveStatistics(
          stats.normalModeStats!.username,
          stats.normalModeStats!.score,
          stats.normalModeStats!.sessionCount,
          QuizMode.normal,
        );
      }

      if (stats.timedModeStats != null) {
        await QuizDatabaseProvider.instance.saveStatistics(
          stats.timedModeStats!.username,
          stats.timedModeStats!.score,
          stats.timedModeStats!.sessionCount,
          QuizMode.timed,
        );
      }
    } catch (e) {
      debugPrint("Stats become null because of $e");
      state = null;
    }
  }
}
