import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/controllers/providers.dart';

class MatrixHeatmap extends ConsumerWidget {
  const MatrixHeatmap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Table(
        children: List.generate(
            6,
            (rowIndex) => TableRow(
                children: List.generate(
                    6,
                    (colIndex) => MatrixContainer(
                          rowIdx: rowIndex,
                          colIdx: colIndex,
                        )))));
  }
}

class MatrixContainer extends ConsumerWidget {
  const MatrixContainer({
    super.key,
    required this.rowIdx,
    required this.colIdx,
  });

  final int rowIdx;
  final int colIdx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
    );
  }
}
