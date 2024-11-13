import 'package:dicey/utils/equal_dist_switch.dart';
import 'package:flutter/material.dart';

class DisplayEqualDist extends StatelessWidget {
  const DisplayEqualDist({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Enable Equal Distribution of Sum:'),
        EqualDistSwitch(),
      ],
    );
  }
}
