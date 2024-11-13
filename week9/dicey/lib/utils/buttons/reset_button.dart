import 'package:dicey/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetButton extends ConsumerWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Do you want to reset all stats?'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Confirm',
              onPressed: () {
                ref.read(diceProvider).resetStatistics();
                final timer = ref.read(timerProvider.notifier);
                timer.resetTimer();
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Reset'));
  }
}
