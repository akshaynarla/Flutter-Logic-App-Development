import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens_utils/screens_utils.dart';

class SumStatsScreen extends ConsumerWidget {
  const SumStatsScreen({super.key, required this.sumidx});

  final String sumidx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int sum = int.tryParse(sumidx) ?? 2;
    int clipSum = sum.clamp(2, 12);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/visualization');
          },
        ),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
      ),
      body: TextDisplaySum(sumIdx: clipSum),
    );
  }
}
