import 'package:dicey_navigation/controllers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../heatmap/heatmap.dart';
import 'package:flutter/material.dart';

class SumDetails extends ConsumerWidget {
  const SumDetails({
    super.key,
    required this.idx,
  });

  final int idx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedSumIdxProvider.notifier).state = idx + 2;
        context.go('/visualization/sumstats');
      },
      child: SumHeatmap(
        idx: idx,
      ),
    );
  }
}
