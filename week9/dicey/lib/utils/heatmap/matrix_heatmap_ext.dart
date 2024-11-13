import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'matrix_container_ext.dart';

class MatrixHeatmapExt extends ConsumerWidget {
  const MatrixHeatmapExt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Table(
        children: List.generate(
            6,
            (rowIndex) => TableRow(
                children: List.generate(
                    6,
                    (colIndex) => MatrixContainerExt(
                          rowIdx: rowIndex,
                          colIdx: colIndex,
                        )))));
  }
}
