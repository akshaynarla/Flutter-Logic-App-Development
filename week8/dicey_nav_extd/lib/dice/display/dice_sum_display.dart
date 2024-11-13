import 'package:dicey_nav_extd/controllers/providers.dart';
import 'package:dicey_nav_extd/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiceSumDisplay extends ConsumerWidget {
  const DiceSumDisplay({
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
          return HoverDisplay(
            idx: index,
          );
        },
      ),
    );
  }
}
