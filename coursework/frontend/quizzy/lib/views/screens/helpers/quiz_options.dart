import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/views/utils/landscape/landscape_task_screen.dart';
import 'package:quizzy/views/utils/portrait/portrait_task_screen.dart';

class QuizOptions extends ConsumerWidget {
  const QuizOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check if landscape mode
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return const LandscapeTaskScreen();
    } else {
      return const PortraitTaskScreen();
    }
  }
}
