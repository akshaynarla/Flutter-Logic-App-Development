import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/controllers/providers.dart';

// App initialization screen
class InitScreen extends ConsumerWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzyState = ref.watch(quizProvider);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: GestureDetector(
        onTap: () {
          if (quizzyState.currentUser != null) {
            // user is currently logged-in (may or may not have valid session, but not logged out)
            context.go('/home');
          } else {
            // go-to login page after initialization of the app
            context.go('/login');
          }
        },
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              Text('Quizzy!!',
                  softWrap: true,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold)),
              Text('A Propositional Logic Quiz App', softWrap: true),
              Text('Developer: Akshay Narla', softWrap: true),
              Text('Tap to begin!!',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
