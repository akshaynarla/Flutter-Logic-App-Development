import 'package:dicey/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UndoButton extends ConsumerWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // bool a = ref.watch(diceHistoryProvider.notifier).undoDisable;
    // debugPrint('a is $a');
    return ElevatedButton(
        onPressed: () => undoActive(ref), child: const Icon(Icons.undo));
    // onPressed: (a) ? null : () => undoActive(ref),
    // child: const Text("Undo"));
  }

  void undoActive(WidgetRef ref) {
    final prevState = ref.watch(diceHistoryProvider.notifier).undo();
    if (prevState != null) {
      ref.watch(diceProvider).restoreState(prevState);
    }
  }
}
