import '../../utils/heatmap/heatmap.dart';
import 'package:flutter/material.dart';

class DiceMatrixDisplay extends StatelessWidget {
  const DiceMatrixDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.85 * MediaQuery.of(context).size.width,
      height: 0.3 * MediaQuery.of(context).size.height,
      child: const MatrixHeatmap(),
    );
  }
}
