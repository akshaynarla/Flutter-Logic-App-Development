import 'package:dicey_navigation/utils/display/display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
