import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dicey/controllers/providers.dart';
import 'package:dicey/dice/dice_import.dart';
import 'package:dicey/utils/utils.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const FittedBox(fit: BoxFit.contain, child: Text('Dicey!!')),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DiceThrow(),
              const ThrowThousandButton(),
              TextOnScreen(
                  txt: 'Number of Throws(since last reset): ',
                  states: ref.watch(diceProvider).numOfThrows),
              Text(
                  'Equal Distribution of Sum Enabled: ${ref.read(diceProvider).equalDist}'),
              displayTimer(timer)
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Text displayTimer(Duration timer) {
    return Text(
      'Time since last throw/s: '
      '${timer.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
      '${timer.inSeconds.remainder(60).toString().padLeft(2, '0')}:'
      '${(timer.inMilliseconds.remainder(1000) ~/ 100).toString().padLeft(1, '0')}',
      style: const TextStyle(fontSize: 14),
    );
  }
}
