import 'package:dicey_nav_extd/dice/dice_import.dart';
import 'package:dicey_nav_extd/utils/display/display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/controllers/providers.dart';

class PortraitDisplay extends ConsumerWidget {
  const PortraitDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const FittedBox(fit: BoxFit.contain, child: Text('Dicey!!')),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.05,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const DisplayEqualDist(),
        const DiceThrow(),
        Text(
            'Number of Throws(since last reset): ${ref.watch(diceProvider).numOfThrows}'),
        const DisplayButtons(),
        const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Sum Statistics of the thrown pair of dice:',
              softWrap: true,
            )),
        const DiceSumDisplay(),
        const SizedBox(
          height: 5,
        ),
        // displaying the 6x6 matrix
        const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Die Outcome Heatmap:',
              softWrap: true,
            )),
        const DiceMatrixDisplay()
      ]),
    );
  }
}
