import 'package:dicey/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RedoButton extends ConsumerWidget {
  const RedoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () => redoActive(ref), child: const Icon(Icons.redo));
  }

  void redoActive(WidgetRef ref) {
    final nextState = ref.watch(diceHistoryProvider.notifier).redo();
    if (nextState != null) {
      ref.watch(diceProvider).restoreState(nextState);
    }
  }
}
