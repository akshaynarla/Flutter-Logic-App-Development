import 'package:dicey/controllers/dice_state.dart';

import '/dice/dice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final diceProvider = ChangeNotifierProvider<Dice>((ref) {
  final diceHistory = ref.read(diceHistoryProvider.notifier);
  return Dice(diceHistory);
});

final diceHistoryProvider =
    StateNotifierProvider<DiceHistoryNotifier, List<Map<String, dynamic>>>(
        (ref) => DiceHistoryNotifier([]));
