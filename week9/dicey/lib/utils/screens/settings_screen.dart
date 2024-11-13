import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dicey/controllers/providers.dart';
import 'package:dicey/utils/utils.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: const FittedBox(fit: BoxFit.contain, child: Text('Dicey!!')),
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextOnScreen(
              txt: 'Number of Throws(since last reset): ',
              states: ref.watch(diceProvider).numOfThrows,
            ),
            const DisplayEqualDist(),
            const ResetButton(),
          ],
        ),
        bottomNavigationBar: const NavBar());
  }
}
