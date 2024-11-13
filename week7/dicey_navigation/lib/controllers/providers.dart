import 'package:dicey_navigation/controllers/dice_state.dart';
import '/dice/dice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dicey_navigation/utils/screens/screens.dart';

import 'selected_index_notifier.dart';

// provider for providing dice class
final diceProvider = ChangeNotifierProvider<Dice>((ref) {
  final diceHistory = ref.read(diceHistoryProvider.notifier);
  return Dice(diceHistory);
});

// provider for storing the state of the dice
final diceHistoryProvider =
    StateNotifierProvider<DiceHistoryNotifier, List<Map<String, dynamic>>>(
        (ref) => DiceHistoryNotifier([]));

// Indexnotifier to activate the bottom navigation bar
final selectedIndexProvider =
    StateNotifierProvider<SelectedIndexNotifier, int>((ref) {
  return SelectedIndexNotifier();
});

// sumIdx for getting the state of the sum statistics
final selectedSumIdxProvider = StateProvider<int>((ref) => 0);
// RowIdx and ColIdx for getting the state of the die statistics
final selectedRowIdxProvider = StateProvider<int>((ref) => 0);
final selectedColIdxProvider = StateProvider<int>((ref) => 0);

// global goRoute provider, so that all routes can be accessed globally.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/visualization',
        builder: (context, state) => VisualizationScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/visualization/throwstats',
        builder: (context, state) => ThrowStatsScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/visualization/sumstats',
        builder: (context, state) => SumStatsScreen(key: state.pageKey),
      )
    ],
  );
});
