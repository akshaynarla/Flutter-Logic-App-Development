import 'package:dicey_navigation/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UndoButton extends ConsumerWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => undoActive(ref),
      child: Icon(
        Icons.undo_sharp,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }

  void undoActive(WidgetRef ref) {
    final prevState = ref.watch(diceHistoryProvider.notifier).undo();
    if (prevState != null) {
      ref.watch(diceProvider).restoreState(prevState);
    }
  }
}
