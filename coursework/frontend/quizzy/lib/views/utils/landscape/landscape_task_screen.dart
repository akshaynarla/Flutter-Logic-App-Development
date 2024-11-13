import 'package:flutter/material.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// here 2 options would be displayed in 1 row by using GridView
class LandscapeTaskScreen extends ConsumerWidget {
  const LandscapeTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = ref.read(quizProvider);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 10,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
          currentState.tasks![currentState.currentTaskIndex].choices.length,
          (choiceIndex) {
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
      }),
    );
  }
}
