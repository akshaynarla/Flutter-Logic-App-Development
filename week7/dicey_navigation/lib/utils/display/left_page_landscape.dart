import 'package:dicey_navigation/controllers/providers.dart';
import 'package:dicey_navigation/dice/dice_throw.dart';
import 'package:dicey_navigation/utils/display/display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeftPageLandscape extends ConsumerWidget {
  const LeftPageLandscape({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 0,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const DisplayEqualDist(),
        const DiceThrow(),
        FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
                'Number of Throws(since last reset): ${ref.watch(diceProvider).numOfThrows}')),
        const DisplayButtons(),
      ]),
    );
  }
}
