import 'package:dicey_nav_extd/controllers/dice_state.dart';
import 'package:dicey_nav_extd/controllers/timer_notifier.dart';
import 'package:dicey_nav_extd/utils/query/cat.dart';
import 'package:dicey_nav_extd/utils/screens/suggest_screen.dart';
import '/dice/dice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dicey_nav_extd/utils/screens/screens.dart';
import '../utils/query/fetch_cat_data.dart';
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
        path: '/suggest',
        builder: (context, state) => SuggestScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/visualization/throwstats/:rowidx/:colidx',
        builder: (context, state) => ThrowStatsScreen(
            key: state.pageKey,
            rowidx: state.pathParameters['rowidx'] ?? '1',
            colidx: state.pathParameters['colidx'] ?? '1'),
      ),
      GoRoute(
        path: '/visualization/sumstats/:sumidx',
        builder: (context, state) => SumStatsScreen(
          key: state.pageKey,
          sumidx: state.pathParameters['sumidx'] ?? '1',
        ),
      )
    ],
  );
});

// provider for timer
final timerProvider = StateNotifierProvider<TimerNotifier, Duration>((ref) {
  return TimerNotifier();
});

// provider for cat images and breeds
final catImageProvider = FutureProvider.family<Cat, int>((ref, diceSum) async {
  return await fetchCatData(ref, diceSum);
});
