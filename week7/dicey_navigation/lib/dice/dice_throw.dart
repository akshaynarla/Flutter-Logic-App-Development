import 'package:dicey_navigation/controllers/providers.dart';
import 'package:dicey_navigation/dice/dice_import.dart';
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
      },
      child: const DiceDisplay(),
    );
  }
}
