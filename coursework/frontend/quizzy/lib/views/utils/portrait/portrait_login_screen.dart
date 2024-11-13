// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/quiz/quiz_api.dart';
import 'package:quizzy/views/utils/screen_utils/login_field.dart';

import '../buttons/text_route_button.dart';

// login screen for portrait mode
class PortraitLoginScreen extends ConsumerWidget {
  const PortraitLoginScreen({
    super.key,
    required this.username,
    required this.passcode,
  });

  final TextEditingController username;
  final TextEditingController passcode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(50.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    const Text('Quizzy!!',
                        softWrap: true,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold)),
                    const Text('A Propositional Logic Quiz App',
                        softWrap: true),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                    LoginField(
                        controllr: username, lablTxt: 'User', hiddn: false),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    LoginField(
                        controllr: passcode, lablTxt: 'Passcode', hiddn: true),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    ElevatedButton(
                      onPressed: () async {
                        bool serverRunning = await isServerOnline();
                        if (serverRunning) {
                          bool success =
                              await userLogin(username.text, passcode.text);
                          // set current username in the quiz controller --> useful for tracking results, getting stats and UI usage
                          if (success) {
                            ref
                                .read(quizProvider.notifier)
                                .setCurrentUser(username.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('Logged in successfully!')));
                            // triggers fetchUserStatistics -- fetched results used later
                            ref
                                .read(userStatisticsProvider.notifier)
                                .fetchUserStatistics();
                            context.go('/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Either passcode or the username is wrong!!')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Server is offline. You will be logged in as a guest. No data is saved!')));
                          ref
                              .read(quizProvider.notifier)
                              .setCurrentUser('guest');
                          // ignore: unused_local_variable
                          bool success = await userLogin('guest', 'guest');
                          context.go('/home');
                        }
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white70)),
                      child: const Text('Login'),
                    ),
                    const TextRouteButton(
                        route: '/resetpw', buttonName: 'Forgot Passcode?'),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                    const TextRouteButton(
                        route: '/register', buttonName: 'First Time User??')
                  ]),
            )));
  }
}
