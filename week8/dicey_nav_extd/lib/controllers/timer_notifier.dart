import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class TimerNotifier extends StateNotifier<Duration> {
  TimerNotifier() : super(Duration.zero);

  Timer? mainTimer;
  DateTime? lastThrowTime;
  Duration? minTime;
  Duration? maxTime;
  Duration? _timeBwThrows;

  void startTimer() {
    lastThrowTime ??= DateTime.now();
    mainTimer?.cancel();
    mainTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      state = DateTime.now().difference(lastThrowTime!);
    });
  }

  void resetTimer() {
    mainTimer?.cancel();
    state = Duration.zero;
    lastThrowTime = null;
    minTime = null;
    maxTime = null;
    _timeBwThrows = null;
  }

  void timeBetweenThrows() {
    if (lastThrowTime != null) {
      final currentTime = DateTime.now();
      final timeDifference = currentTime.difference(lastThrowTime!);
      minTime = minTime == null || timeDifference < minTime!
          ? timeDifference
          : minTime!;
      maxTime = maxTime == null || timeDifference > maxTime!
          ? timeDifference
          : maxTime!;
      _timeBwThrows = timeDifference;
      lastThrowTime = currentTime;
    }
  }

  Duration? get minTimeBetweenThrows => minTime;
  Duration? get maxTimeBetweenThrows => maxTime;
  Duration? get timeBwThrows => _timeBwThrows;

  @override
  void dispose() {
    mainTimer?.cancel();
    super.dispose();
  }
}
