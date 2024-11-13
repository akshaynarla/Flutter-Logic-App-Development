import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/controllers/route_provider.dart';

// entry point to quizzy app
class QuizzyApp extends ConsumerWidget {
  const QuizzyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // routing for the app, using global provider
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true),
    );
  }
}
