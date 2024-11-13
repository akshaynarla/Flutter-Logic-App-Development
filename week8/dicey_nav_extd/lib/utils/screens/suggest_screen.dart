import 'package:dicey_nav_extd/utils/query/cat_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dicey_nav_extd/utils/utils.dart';
import '../../controllers/providers.dart';

class SuggestScreen extends ConsumerWidget {
  const SuggestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceSum =
        ref.watch(diceProvider).diceOne + ref.watch(diceProvider).diceTwo;
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
            children: [Text('The sum is: $diceSum'), const CatImage()],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
