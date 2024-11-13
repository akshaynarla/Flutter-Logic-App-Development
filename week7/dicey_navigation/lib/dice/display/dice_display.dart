import 'package:dicey_navigation/controllers/providers.dart';
import 'package:dicey_navigation/dice/dice_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiceDisplay extends ConsumerWidget {
  const DiceDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      // display dice in the home page
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // ref.watch here because the image has to change based on the notifier change
        DiceImage(diceName: ref.watch(diceProvider).diceOne),
        DiceImage(diceName: ref.watch(diceProvider).diceTwo),
      ],
    );
  }
}
