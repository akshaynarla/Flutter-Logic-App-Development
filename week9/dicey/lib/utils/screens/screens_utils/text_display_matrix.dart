import 'package:dicey/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'text_on_screen.dart';

class TextDisplayMatrix extends ConsumerWidget {
  const TextDisplayMatrix({
    super.key,
    required this.rowIdx,
    required this.colIdx,
  });

  final int rowIdx;
  final int colIdx;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dieData =
        ref.read(diceProvider).dieStatistics[rowIdx - 1][colIdx - 1];
    final maxElement = ref
        .read(diceProvider)
        .dieStatistics
        .expand((row) => row)
        .reduce((a, b) => a > b ? a : b);
    final int rowMax = ref
        .read(diceProvider)
        .dieStatistics
        .indexWhere((row) => row.contains(maxElement));
    final int colMax =
        ref.read(diceProvider).dieStatistics[rowMax].indexOf(maxElement);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          displayData(rowIdx, colIdx, dieData, ref, rowMax, colMax, maxElement),
    );
  }

  List<Widget> displayData(int rowIdx, int colIdx, int dieData, WidgetRef ref,
      int rowMax, int colMax, int maxElement) {
    return [
      Text(
        'Selected Die Throw: ($rowIdx,$colIdx)',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      TextOnScreen(
          txt: 'Number of throws with above output: ', states: dieData),
      Text(
        'Sum of the Selected Die Throw: ${rowIdx + colIdx}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      TextOnScreen(
          txt: 'Total Number of Throws: ',
          states: ref.read(diceProvider).numOfThrows),
      const SizedBox(width: 10, height: 10),
      Text(
        'Most common Die Throw outcome: (${rowMax + 1}, ${colMax + 1})',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      TextOnScreen(txt: 'Number of outcomes:', states: maxElement)
    ];
  }
}
