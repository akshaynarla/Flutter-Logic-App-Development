import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/views/screens/helpers/quiz_options.dart';

// widget to display the quiz question and options
class QuizQuestion extends ConsumerWidget {
  const QuizQuestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = ref.read(quizProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Question ${currentState.currentTaskIndex + 1} of 10',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              currentState.tasks![currentState.currentTaskIndex].question,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center),
        ),
        const QuizOptions(),
      ],
    );
  }
}
