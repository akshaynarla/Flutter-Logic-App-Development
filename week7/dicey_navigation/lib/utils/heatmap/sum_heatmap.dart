import 'package:dicey_navigation/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SumHeatmap extends ConsumerWidget {
  const SumHeatmap({
    super.key,
    required this.idx,
  });
  final int idx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      color: Color.fromARGB(
        255,
        (255 *
                ref.watch(diceProvider).sumStatistics[idx] ~/
                (ref.watch(diceProvider).numOfThrows + 1))
            .clamp(0, 255),
        255 -
            (255 *
                    ref.watch(diceProvider).sumStatistics[idx] ~/
                    (ref.watch(diceProvider).numOfThrows + 1))
                .clamp(0, 255),
        150,
      ),
      padding: const EdgeInsets.all(6),
    );
  }
}
