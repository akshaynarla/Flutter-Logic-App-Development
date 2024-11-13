import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzy/controllers/providers.dart';

class StatsHelper extends ConsumerWidget {
  const StatsHelper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final normalStats = ref.watch(normalStatsProvider);
    final timedStats = ref.watch(timedStatsProvider);
    final currentUser = ref.read(quizProvider).currentUser;

    if (currentUser == 'guest') {
      return const Text("No data stored for guest user mode.");
    } else {
      return Column(
        children: [
          const Text('Normal mode',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
              "Number of normal sessions: ${normalStats?.sessionCount ?? 'N/A'}"),
          Text(
              "Normal mode: Accuracy: ${(normalStats?.score ?? 0) / (normalStats?.sessionCount ?? 1)}"),
          const Text('Timed mode',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
              "Number of timed sessions: ${timedStats?.sessionCount ?? 'N/A'}"),
          Text(
              "Timed Mode: Accuracy ${(timedStats?.score ?? 0) / (timedStats?.sessionCount ?? 1)}"),
        ],
      );
    }
  }
}
