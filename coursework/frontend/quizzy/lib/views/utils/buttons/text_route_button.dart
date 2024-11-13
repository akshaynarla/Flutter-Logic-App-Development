// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TextRouteButton extends StatelessWidget {
  const TextRouteButton(
      {super.key, required this.route, required this.buttonName});

  final String route;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          // navigate to the reset passcode screen
          context.go(route);
        },
        child: Text(buttonName));
  }
}
