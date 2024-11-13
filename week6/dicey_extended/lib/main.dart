import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'utils/display/display.dart';

void main() {
  runApp(const ProviderScope(child: DiceyApp()));
}

class DiceyApp extends StatelessWidget {
  const DiceyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true),
      home: const DiceyHome(),
    );
  }
}

class DiceyHome extends ConsumerWidget {
  const DiceyHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return const LandscapeDisplay();
        } else {
          return const PortraitDisplay();
        }
      },
    );
  }
}
