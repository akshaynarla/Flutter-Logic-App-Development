// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/quiz/quiz_api.dart';
import 'package:quizzy/views/utils/screen_utils/login_field.dart';

// user registration page in UI
class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController username = TextEditingController();
    final TextEditingController passcode = TextEditingController();
    final TextEditingController confirmPasscode = TextEditingController();
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
              const Text('User Registration', softWrap: true),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              LoginField(
                  controllr: username, lablTxt: 'Username', hiddn: false),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              LoginField(controllr: passcode, lablTxt: 'Passcode', hiddn: true),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              LoginField(
                  controllr: confirmPasscode,
                  lablTxt: 'Confirm Passcode',
                  hiddn: true),
              ElevatedButton(
                onPressed: () async {
                  // allow registration only if passcode and confirmed passcode are same
                  if (passcode.text == confirmPasscode.text) {
                    // use API call to register the user into server
                    bool serverRunning = await isServerOnline();
                    if (serverRunning) {
                      bool success =
                          await userRegistration(username.text, passcode.text);
                      if (success) {
                        // indicate if registration is successful --> go-to homepage
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text(
                                'Registered successfully! Login with your account details now!!')));
                      } else {
                        // go back to login page if server responds registration failed and indicate
                        // guest login using "guest"
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Registration Failed!! Use a different username or try guest mode!')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Server is offline. Please come back later or try the offline mode with guest!')));
                    }
                    context.go('/login');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passcodes not same!')));
                    context.go('/register');
                  }
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white70)),
                child: const Text('Register User'),
              ),
            ])));
  }
}
