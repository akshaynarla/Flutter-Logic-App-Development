import '../../utils/heatmap/heatmap.dart';
import 'package:flutter/material.dart';

class DiceMatrixDisplayExt extends StatelessWidget {
  const DiceMatrixDisplayExt({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.85 * MediaQuery.of(context).size.width,
      height: 0.3 * MediaQuery.of(context).size.height,
      child: const MatrixHeatmapExt(),
    );
  }
}
