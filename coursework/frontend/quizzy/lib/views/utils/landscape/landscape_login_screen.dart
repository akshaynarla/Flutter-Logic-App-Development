// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/quiz/quiz_api.dart';
import 'package:quizzy/controllers/providers.dart';
import 'package:quizzy/views/utils/buttons/text_route_button.dart';
import 'package:quizzy/views/utils/screen_utils/login_field.dart';

// login screen in landscape mode -> same functionality as portrait mode
// with screen adjustments
class LandscapeLoginScreen extends ConsumerWidget {
  const LandscapeLoginScreen({
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Quizzy!!',
                  softWrap: true,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              const Text('A Propositional Logic Quiz App', softWrap: true),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              Row(
                children: [
                  Flexible(
                    child: LoginField(
                        controllr: username, lablTxt: 'User', hiddn: false),
                  ),
                  Flexible(
                    child: LoginField(
                        controllr: passcode, lablTxt: 'Passcode', hiddn: true),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      bool serverRunning = await isServerOnline();
                      if (serverRunning) {
                        bool success =
                            await userLogin(username.text, passcode.text);
                        // on successful login, set the current username in the
                        // quiz controller state notifier
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
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Either passcode or the username is wrong!!')));
                          context.go('/');
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Server is offline. You will be logged in as a guest. No data is saved!')));
                        ref.read(quizProvider.notifier).setCurrentUser('guest');
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
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              const TextRouteButton(
                  route: '/register', buttonName: 'First Time User??')
            ]),
          ),
        ));
  }
}
