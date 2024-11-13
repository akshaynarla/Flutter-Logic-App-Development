import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quizzy/views/utils/buttons/tap_start_quiz.dart';

// widget for updating the mode provider for appropriate quiz mode selection
// although, the normal session and timed session screen widgets are the same,
// for separate routing purposes they are provided as 2 widgets.
class NormalSessionScreen extends ConsumerWidget {
  const NormalSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const FittedBox(fit: BoxFit.contain, child: Text('Quizzy!!')),
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              TapStartQuiz(),
            ],
          ),
        )));
  }
}
