import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/views/utils/buttons/grey_button.dart';

// QuizExit widget displays the quiz review
// provides user with feedback and the session score.
// user can swipe through the tasks here.
class QuizExit extends ConsumerWidget {
  const QuizExit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final sessionScore = quizState.sessionScore;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const FittedBox(
              fit: BoxFit.contain, child: Text('Quizzy Session Review')),
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.05),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.8,
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: Expanded(
              flex: 2,
              child: PageView.builder(
                itemCount: quizState.tasks!.length,
                itemBuilder: (context, index) {
                  final task = quizState.tasks![index];
                  final isCorrect = quizState.taskStatus[index] ?? false;
                  final actualAnswer = task.correctAns;
                  final selectedOptionIndex =
                      quizState.selectedOptionsList[index];
                  return ListTile(
                    title: Text(task.question),
                    subtitle: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: task.choices.length,
                      itemBuilder: (context, choiceIndex) {
                        final option = task.choices[choiceIndex];
                        Color textColor = Colors.black;
                        // determine if the selected option by the user was correct or not
                        if (choiceIndex == selectedOptionIndex) {
                          textColor = isCorrect ? Colors.green : Colors.red;
                        }
                        // Mark the correct answer in green
                        if (choiceIndex == actualAnswer) {
                          textColor = Colors.green;
                        }
                        return Text(option, style: TextStyle(color: textColor));
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Text('Score: $sessionScore / ${quizState.tasks!.length}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const GreyButton(routeStr: '/home', buttonName: 'Do not review!')
        ],
      ),
    );
  }
}
