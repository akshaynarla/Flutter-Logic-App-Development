import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../heatmap/heatmap.dart';
import '/controllers/providers.dart';
import 'package:flutter/material.dart';

class HoverDisplay extends ConsumerWidget {
  const HoverDisplay({
    super.key,
    required this.idx,
  });

  final int idx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Count of throws with sum ${idx + 2} is: ${ref.read(diceProvider).sumStatistics[idx]}'),
          duration: const Duration(seconds: 1),
        ));
      },
      child: SumHeatmap(
        idx: idx,
      ),
    );
  }
}
