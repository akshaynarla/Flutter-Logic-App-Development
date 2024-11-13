import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/controllers/stat_notifier.dart';
import 'package:quizzy/quiz/quiz.dart';

import 'package:timer_count_down/timer_controller.dart';

// provider for quiz and related functionalities (stats, next questions and so on)
final quizProvider =
    StateNotifierProvider<QuizStatus, QuizState>((ref) => QuizStatus());

// countdown timer provider
final countdownControllerProvider = Provider<CountdownController>((ref) {
  return CountdownController(autoStart: true);
});

// providers of stats --> useful for statshelper widget
final normalStatsProvider = StateProvider<UserStatistic?>((ref) => null);
final timedStatsProvider = StateProvider<UserStatistic?>((ref) => null);

// stats provider --> used for making the user stats fetched from server to be available globally
// following style triggers the fetch operation as soon as the notifier is created
// reference: https://pub.dev/packages/state_notifier --> good practices section
final userStatisticsProvider =
    StateNotifierProvider<UserStatisticsNotifier, UserStatistics?>((ref) {
  final notifier = UserStatisticsNotifier();
  notifier.fetchUserStatistics();
  return notifier;
});

// provider for storing user cookie --> consists of session token
final sessionCookieProvider = StateProvider<String?>((ref) => null);
