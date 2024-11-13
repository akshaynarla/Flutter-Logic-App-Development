import 'package:dicey/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MatrixContainerExt extends ConsumerWidget {
  const MatrixContainerExt({
    super.key,
    required this.rowIdx,
    required this.colIdx,
  });

  final int rowIdx;
  final int colIdx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        context.go('/visualization/throwstats/${rowIdx + 1}/${colIdx + 1}');
      },
      child: Container(
        color: Color.fromARGB(
          255,
          (255 *
                  ref.watch(diceProvider).dieStatistics[rowIdx][colIdx] ~/
                  (ref.watch(diceProvider).numOfThrows + 1))
              .clamp(0, 255),
          255 -
              (255 *
                      ref.watch(diceProvider).dieStatistics[rowIdx][colIdx] ~/
                      (ref.watch(diceProvider).numOfThrows + 1))
                  .clamp(0, 255),
          150,
        ),
        padding: const EdgeInsets.all(6),
        child: Text('${ref.watch(diceProvider).dieStatistics[rowIdx][colIdx]}'),
      ),
    );
  }
}
