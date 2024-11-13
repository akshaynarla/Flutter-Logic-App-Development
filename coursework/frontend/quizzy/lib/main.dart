import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/quiz/quiz.dart';
import 'package:quizzy/quizzy.dart';

// Reference for override: https://codewithandrea.com/articles/flutter-state-management-riverpod/
// Reference 2: https://stackoverflow.com/questions/74202620/riverpod-2-0-override-with-value-does-not-exist-anymore
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(overrides: [
    quizProvider.overrideWith((ref) => QuizStatus()..quizzyRestart())
  ], child: const QuizzyApp()));
}
