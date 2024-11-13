import 'package:dicey_nav_extd/dice/dice_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RightPageLandscape extends ConsumerWidget {
  const RightPageLandscape({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Sum Statistics of the thrown pair of dice:',
                softWrap: true,
              )),
          DiceSumDisplay(),
          SizedBox(
            height: 10,
          ),
          // displaying the 6x6 matrix
          FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Die Outcome Heatmap:',
                softWrap: true,
              )),
          DiceMatrixDisplay(),
        ],
      ),
    );
  }
}
