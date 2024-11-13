import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dicey_navigation/controllers/providers.dart';
import 'package:dicey_navigation/dice/dice_import.dart';
import 'package:dicey_navigation/utils/utils.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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
        children: [
          const DiceThrow(),
          const ThrowThousandButton(),
          TextOnScreen(
              txt: 'Number of Throws(since last reset): ',
              states: ref.watch(diceProvider).numOfThrows),
          Text(
              'Equal Distribution of Sum Enabled: ${ref.read(diceProvider).equalDist}'),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
