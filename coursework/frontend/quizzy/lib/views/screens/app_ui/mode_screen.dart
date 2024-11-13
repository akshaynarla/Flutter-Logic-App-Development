import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/controllers/providers.dart';

import 'package:quizzy/views/utils/buttons/grey_button.dart';

// display or UI for mode selection i.e., timed or normal mode. More details on app guide page
class ModeScreen extends ConsumerWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.read(quizProvider).currentUser;
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(50.0),
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                height: MediaQuery.sizeOf(context).height * 0.8,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    children: modeWidgets(context, userName)))));
  }

  List<Widget> modeWidgets(BuildContext context, dynamic userName) {
    return [
      const Text('Quizzy!!',
          softWrap: true,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 24.0,
              fontWeight: FontWeight.bold)),
      const Text('A Propositional Logic Quiz App', softWrap: true),
      Text('New session for: $userName'),
      SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
      const GreyButton(routeStr: '/home/mode/timed', buttonName: 'Timed Mode'),
      SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
      const GreyButton(
          routeStr: '/home/mode/normal', buttonName: 'Normal Mode'),
      SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
      TextButton(
          onPressed: () {
            context.go('/home');
          },
          child: const Text('Homepage')),
    ];
  }
}
