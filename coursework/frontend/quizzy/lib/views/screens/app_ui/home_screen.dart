import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/landscape/landscape_home_screen.dart';
import '../../utils/portrait/portrait_home_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
          return const PortraitHomeScreen();
        } else {
          return const LandscapeHomeScreen();
        }
      },
    );
  }
}
