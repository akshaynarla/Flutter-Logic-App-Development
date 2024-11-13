import 'package:dicey_navigation/controllers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'text_on_screen.dart';

class TextDisplaySum extends ConsumerWidget {
  const TextDisplaySum({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int maxSumVal = ref
        .read(diceProvider)
        .sumStatistics
        .reduce((value, element) => value > element ? value : element);
    final int maxIndex =
        ref.read(diceProvider).sumStatistics.indexOf(maxSumVal) + 2;
    final int sumIdx = ref.read(selectedSumIdxProvider.notifier).state;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: displayData(sumIdx, ref, maxIndex, maxSumVal),
    );
  }

  List<Widget> displayData(
      int sumIdx, WidgetRef ref, int maxIndex, int maxSumVal) {
    return [
      TextOnScreen(txt: 'Selected Sum is: ', states: sumIdx),
      TextOnScreen(
          txt: 'Number of throws with above sum value: ',
          //states: ref.read(selectedSumProvider.notifier).state),
          states: ref.read(diceProvider).sumStatistics[sumIdx - 2]),
      TextOnScreen(
          txt: 'Total Number of Throws: ',
          states: ref.read(diceProvider).numOfThrows),
      const SizedBox(width: 10, height: 10),
      TextOnScreen(
          txt: 'Maximal number of sum encountered: ', states: maxIndex),
      TextOnScreen(
          txt: 'Maximal number of throws of a sum: ', states: maxSumVal),
    ];
  }
}
