// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/database/quiz_db.dart';
import 'package:quizzy/quiz/quiz.dart';

class GreyButton extends ConsumerWidget {
  const GreyButton(
      {super.key, required this.routeStr, required this.buttonName});

  final String routeStr;
  final String buttonName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(quizProvider).currentUser;
    return ElevatedButton(
        onPressed: () async {
          if (routeStr.endsWith('/mode/timed')) {
            ref.read(quizProvider.notifier).updateMode(QuizMode.timed);
          } else if (routeStr.endsWith('/mode/normal')) {
            ref.read(quizProvider.notifier).updateMode(QuizMode.normal);
          } else if (routeStr.endsWith('/stats')) {
            if (currentUser == 'guest') {
              // do nothing and go to stats screen
            } else {
              // get stored data from sqflite database
              var db = QuizDatabaseProvider.instance;
              final normalStats =
                  await db.getUserStatistic(currentUser, 'normal');
              final timedStats =
                  await db.getUserStatistic(currentUser, 'timed');
              if (normalStats != null) {
                ref.read(normalStatsProvider.notifier).state = normalStats;
              }
              if (timedStats != null) {
                ref.read(timedStatsProvider.notifier).state = timedStats;
              }
            }
          }
          // navigate to the routeStr screen
          context.go(routeStr);
        },
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.white70),
            fixedSize: MaterialStatePropertyAll(Size(
                MediaQuery.sizeOf(context).width * 0.4,
                MediaQuery.sizeOf(context).height * 0.05))),
        child: Text(buttonName));
  }
}
