import 'package:flutter/material.dart';

class DiceImage extends StatelessWidget {
  const DiceImage({
    super.key,
    required this.diceName,
  });

  final int diceName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.24 * MediaQuery.of(context).size.width,
      height: 0.24 * MediaQuery.of(context).size.height,
      child: FittedBox(
        child: Image.asset(
          'assets/images/dice$diceName.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
