// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/quiz/quiz_api.dart';
import 'package:quizzy/views/utils/buttons/grey_button.dart';

class LandscapeHomeScreen extends ConsumerWidget {
  const LandscapeHomeScreen({
    super.key,
  });

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
                  children: [
                    const Text('Quizzy!!',
                        softWrap: true,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold)),
                    const Text('A Propositional Logic Quiz App',
                        softWrap: true),
                    Text('Signed in as: $userName'),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                    const Flexible(
                      child: Row(
                        children: [
                          GreyButton(
                              routeStr: '/home/mode',
                              buttonName: 'New Session'),
                          GreyButton(
                              routeStr: '/home/stats',
                              buttonName: 'User Stats'),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    const GreyButton(
                        routeStr: '/home/appguide', buttonName: 'App Guide'),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                    TextButton(
                        onPressed: () async {
                          bool serverRunning = await isServerOnline();
                          if (serverRunning) {
                            bool success = await userLogout(userName);
                            if (success) {
                              ref.read(quizProvider.notifier).logout();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content:
                                          Text('Logged out successfully!')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Session Expired. Current session data might get lost!')));
                            }
                            context.go('/login');
                          } else if (userName == 'guest') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('Logged out successfully!')));
                            context.go('/login');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Server is offline. Session Data will not be saved when you logout!')));
                            context.go('/login');
                          }
                        },
                        child: const Text('Sign Out')),
                  ],
                ))));
  }
}
