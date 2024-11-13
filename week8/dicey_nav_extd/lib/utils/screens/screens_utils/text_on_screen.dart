import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextOnScreen extends ConsumerWidget {
  const TextOnScreen({
    super.key,
    required this.txt,
    required this.states,
  });

  final String txt;
  final int? states;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text.rich(
      TextSpan(children: <TextSpan>[
        TextSpan(text: txt),
        TextSpan(
          text: '$states',
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ]),
      textAlign: TextAlign.center,
    );
  }
}
