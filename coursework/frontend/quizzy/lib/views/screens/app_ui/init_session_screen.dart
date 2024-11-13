// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/database/quiz_db.dart';
import 'package:quizzy/quiz/quiz_api.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/quiz/quiz.dart';
import 'package:quizzy/views/screens/helpers/quiz_question.dart';

// InitSessionScreen widget is the main quiz screen
// All quiz UI handling done here. Initializes the quiz session and
// takes it to end --> while updating the quiz state
class InitSessionScreen extends ConsumerWidget {
  const InitSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizStatus = ref.watch(quizProvider);
    final timerController = ref.watch(countdownControllerProvider);
    final PageController pageManager = PageController(
      initialPage: quizStatus.currentTaskIndex,
    );

    void moveToNextQuestion() async {
      final currentState = ref.read(quizProvider);
      final selectedOption = currentState.selectedOptionIndex;
      // before moving to next question check if the current provided answer
      // is correct or not and update the task status
      if (selectedOption != null) {
        final isCorrect =
            currentState.tasks![currentState.currentTaskIndex].correctAns ==
                selectedOption;
        ref
            .read(quizProvider.notifier)
            .updateTaskStatus(currentState.currentTaskIndex, isCorrect);
        ref.read(quizProvider.notifier).updateSelectedOptionsList();
      }

      final nextPage = ref.read(quizProvider).currentTaskIndex + 1;
      // moving to next page
      if (nextPage < 10) {
        pageManager.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        // Update the current task index in your quizStatus provider and clear selected option
        ref.read(quizProvider.notifier).updateCurrentTaskIndex(nextPage);
        ref.read(quizProvider.notifier).selectedOption(0);
        if (ref.read(quizProvider).quizMode == QuizMode.timed) {
          timerController.restart();
        }
      } else {
        final currentTaskStatus = ref.read(quizProvider).taskStatus;
        // update stats in local database and also send to server
        // and move to feedback or quiz exit page
        final thisSessionScore = ref
            .read(quizProvider.notifier)
            .calculateSessionScore(currentTaskStatus);
        ref.read(quizProvider.notifier).setSessionScore(thisSessionScore);
        ref.read(quizProvider.notifier).updateQuizFin();
        bool serverRunning = await isServerOnline();
        if (serverRunning && currentState.currentUser != 'guest') {
          QuizDatabaseProvider.instance
              .sendUserStatToServer(currentState.currentUser);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 2),
              content: Text(
                  'Server is not running! Your data will not be saved to server now!!')));
        }
        context.go('/home/mode/exit');
      }
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            centerTitle: true,
            title:
                const FittedBox(fit: BoxFit.contain, child: Text('Quizzy!!')),
            toolbarHeight: MediaQuery.sizeOf(context).height * 0.1),
        body: SingleChildScrollView(
            child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.7,
          child: Column(children: [
            if (ref.read(quizProvider).quizMode == QuizMode.timed)
              Countdown(
                controller: timerController,
                seconds: 45,
                build: (_, double time) => Text(
                  time.toString(),
                  style: const TextStyle(fontSize: 30),
                ),
                onFinished: () {
                  moveToNextQuestion();
                },
              ),
            Expanded(
              // physics set to never scrollable here --> default android will scroll automatically
              // we want the user to press "next" to move to next question once answered
              // creates 10 on-demand quiz questions based on the builder
              child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageManager,
                  itemCount: ref.read(quizProvider).tasks!.length,
                  itemBuilder: (context, index) {
                    return const QuizQuestion();
                  }),
            ),
            ElevatedButton(
              onPressed: moveToNextQuestion,
              child: const Text('Next'),
            ),
          ]),
        )));
  }
}
