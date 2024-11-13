import 'package:dicey_navigation/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThrowThousandButton extends ConsumerWidget {
  const ThrowThousandButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          ref
              .read(diceProvider)
              .throwThousand(ref.read(diceProvider).equalDist);
        },
        child: const Text('Make 1000 throws'));
  }
}
