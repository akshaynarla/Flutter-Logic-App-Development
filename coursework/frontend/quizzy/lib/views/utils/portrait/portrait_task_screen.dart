import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/controllers/providers.dart';

// provides a list of options as elevated button
// the selected index is updated in the quiz state for further evaluation
class PortraitTaskScreen extends ConsumerWidget {
  const PortraitTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = ref.read(quizProvider);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          currentState.tasks![currentState.currentTaskIndex].choices.length,
      itemBuilder: (context, choiceIndex) {
        final option = currentState
            .tasks![currentState.currentTaskIndex].choices[choiceIndex];
        final isAnswered =
            ref.watch(quizProvider).selectedOptionIndex == choiceIndex;
        return ElevatedButton(
          onPressed: isAnswered
              ? null
              : () {
                  ref.read(quizProvider.notifier).selectedOption(choiceIndex);
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: isAnswered ? Colors.black38 : Colors.white,
          ),
          child: Text(option),
        );
      },
    );
  }
}
