import 'package:dicey_nav_extd/controllers/providers.dart';
import 'package:dicey_nav_extd/dice/dice_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiceThrow extends ConsumerWidget {
  const DiceThrow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(diceProvider).throwDice(ref.read(diceProvider).equalDist);
        final timer = ref.read(timerProvider.notifier);
        timer.startTimer();
        timer.timeBetweenThrows();
      },
      child: const DiceDisplay(),
    );
  }
}
