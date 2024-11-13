// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

// loginField is used for all entry fields in the app
// example: login, registration, reset passcode
class LoginField extends StatelessWidget {
  const LoginField(
      {super.key,
      required this.controllr,
      required this.lablTxt,
      required this.hiddn});

  final TextEditingController controllr;
  final String? lablTxt;
  final bool hiddn;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hiddn,
      controller: controllr,
      decoration: InputDecoration(
        labelText: lablTxt,
        border: const OutlineInputBorder(),
        filled: true,
      ),
    );
  }
}
