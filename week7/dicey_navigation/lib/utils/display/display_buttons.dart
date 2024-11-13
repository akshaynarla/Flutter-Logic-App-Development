import '../utils.dart';
import 'package:flutter/material.dart';

class DisplayButtons extends StatelessWidget {
  const DisplayButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ResetButton(), ThrowThousandButton()]),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [UndoButton(), RedoButton()],
        )
      ],
    );
  }
}
