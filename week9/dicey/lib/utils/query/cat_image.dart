import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/providers.dart';

class CatImage extends ConsumerWidget {
  const CatImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceSum = ref.read(diceProvider.notifier).diceOne +
        ref.read(diceProvider.notifier).diceTwo;
    final catImageAsyncValue = ref.watch(catImageProvider(diceSum));
    return SizedBox(
      child: catImageAsyncValue.when(
        data: (cat) => Center(
            child: Image.network(
          cat.imageUrl,
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height - 35,
          fit: BoxFit.contain,
        )),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
