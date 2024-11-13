import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/views/screens/helpers/stats_helper.dart';

// UI for user stat display
class StatScreen extends ConsumerWidget {
  const StatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(50.0),
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                height: MediaQuery.sizeOf(context).height * 0.9,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    children: statWidgets(context, ref)))));
  }

  List<Widget> statWidgets(BuildContext context, WidgetRef ref) {
    return [
      const Text('Quizzy!!',
          softWrap: true,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 24.0,
              fontWeight: FontWeight.bold)),
      const Text('A Propositional Logic Quiz App', softWrap: true),
      SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
      Text("${ref.read(quizProvider).currentUser}'s stats"),
      SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
      const StatsHelper(),
      TextButton(
          onPressed: () {
            context.go('/home');
          },
          child: const Text('Homepage')),
    ];
  }
}
