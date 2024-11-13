import 'package:dicey_navigation/controllers/providers.dart';
import 'package:dicey_navigation/utils/screens/screens_utils/sum_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiceSumDisplayExt extends ConsumerWidget {
  const DiceSumDisplayExt({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 0.05 * MediaQuery.of(context).size.height),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: ref.read(diceProvider).sumStatistics.length,
        itemBuilder: (context, index) {
          return SumDetails(
            idx: index,
          );
        },
      ),
    );
  }
}
