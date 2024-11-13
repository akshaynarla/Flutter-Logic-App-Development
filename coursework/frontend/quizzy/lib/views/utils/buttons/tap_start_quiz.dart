// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/database/quiz_db.dart';
import 'package:quizzy/quiz/quiz.dart';
import 'package:quizzy/quiz/quiz_api.dart';

// logic for fetching quiz tasks from: https://github.com/zjhnb11/logic_quiz_App
class TapStartQuiz extends ConsumerWidget {
  const TapStartQuiz({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.read(quizProvider.notifier);

    return ElevatedButton(
      onPressed: () async {
        quizState.resetQuiz();
        // check if backend/server is running and get questions accordingly
        bool serverRunning = await isServerOnline();
        var db = QuizDatabaseProvider.instance;

        if (serverRunning) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 2),
              content: Text('Connected to Server!')));
          // clear any question existing in local database
          await db.clearQuestions();
          // fetch quiz tasks from server
          var tasksOnline = await fetchTasks();
          // in case no tasks fetched due to session expiration and/or backend database failure
          if (tasksOnline == []) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 3),
                content: Text(
                    'Session expired or database is faulty. Logout and log in again for a fresh session!')));
            context.go('/home');
          } else {
            await db.insertTasks(tasksOnline);
            quizState.loadQuestions();
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 2),
              content:
                  Text('Server is not running! Fetching offline tasks...')));
          await db.clearQuestions();
          await db.insertTasks(offlineTasks);
          quizState.loadQuestions();
        }
        // go to quiz UI
        context.go('/home/mode/init');
      },
      child: const Text('Tap to start your quiz!'),
    );
  }
}
