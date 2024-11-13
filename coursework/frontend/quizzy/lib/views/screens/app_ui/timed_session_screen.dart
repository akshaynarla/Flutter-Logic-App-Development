import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quizzy/views/utils/buttons/tap_start_quiz.dart';

// TImedSessionScreen acts as the initialization for timed mode of quiz
class TimedSessionScreen extends ConsumerWidget {
  const TimedSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const FittedBox(fit: BoxFit.contain, child: Text('Quizzy!!')),
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
        ),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              SizedBox(height: 20),
              TapStartQuiz(),
            ],
          ),
        ));
  }
}
