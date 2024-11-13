import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/landscape/landscape_login_screen.dart';
import '../../utils/portrait/portrait_login_screen.dart';

// Login screen UI
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController username = TextEditingController();
    final TextEditingController passcode = TextEditingController();
    return LayoutBuilder(builder: (context, constraints) {
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        return PortraitLoginScreen(username: username, passcode: passcode);
      } else {
        return LandscapeLoginScreen(username: username, passcode: passcode);
      }
    });
  }
}
