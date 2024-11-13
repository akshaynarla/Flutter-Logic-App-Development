import 'package:dicey_nav_extd/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EqualDistSwitch extends ConsumerWidget {
  const EqualDistSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Switch(
      value: ref.watch(diceProvider).equalDist,
      onChanged: (value) {
        ref.read(diceProvider).enableEqualDist(value);
      },
    );
  }
}
