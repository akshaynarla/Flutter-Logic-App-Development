// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/quiz/quiz_api.dart';
import 'package:quizzy/views/utils/screen_utils/login_field.dart';

class ResetPasscode extends ConsumerWidget {
  const ResetPasscode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController username = TextEditingController();
    final TextEditingController newpasscode = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const FittedBox(fit: BoxFit.contain, child: Text('Quizzy!!')),
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
        ),
        body: SingleChildScrollView(
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
              const Text('User Password Reset', softWrap: true),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              LoginField(
                  controllr: username, lablTxt: 'Username', hiddn: false),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              LoginField(
                  controllr: newpasscode, lablTxt: 'New Passcode', hiddn: true),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              ElevatedButton(
                onPressed: () async {
                  // use API call to reset the user passcode only if server is running
                  bool serverRunning = await isServerOnline();
                  if (serverRunning) {
                    bool success =
                        await resetPasscode(username.text, newpasscode.text);
                    if (success) {
                      // indicate if reset password is successful --> go-to login page
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                              'Password reset successfull! Login again!')));
                      context.go('/login');
                    } else {
                      // Username does not exist in the serverside database
                      // go back to login page for user to register
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Username does not exist. Please register!')));
                      context.go('/register');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Server is offline. Please reset passcode later!')));
                    context.go('/login');
                  }
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white70)),
                child: const Text('Confirm'),
              ),
            ])));
  }
}
