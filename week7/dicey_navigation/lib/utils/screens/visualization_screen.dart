import 'package:dicey_navigation/dice/dice_import.dart';
import 'package:dicey_navigation/utils/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dicey_navigation/controllers/providers.dart';
import '../misc/nav_bar.dart';

class VisualizationScreen extends ConsumerWidget {
  const VisualizationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const FittedBox(fit: BoxFit.contain, child: Text('Dicey!!')),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: TextOnScreen(
              txt: 'Number of Throws(since last reset): ',
              states: ref.watch(diceProvider).numOfThrows,
            ),
          ),
          Text(
              'Equal Distribution of Sum Enabled: ${ref.read(diceProvider).equalDist}'),
          const FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              child: Text(
                'Sum Statistics of the thrown pair of dice:',
                softWrap: true,
              )),
          const DiceSumDisplayExt(),
          const SizedBox(
            height: 10,
          ),
          // displaying the 6x6 matrix
          const FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              child: Text(
                'Die Outcome Heatmap:',
              )),
          const DiceMatrixDisplayExt(),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
