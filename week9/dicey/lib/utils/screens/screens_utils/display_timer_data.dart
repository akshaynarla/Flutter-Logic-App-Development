import 'package:dicey/controllers/timer_notifier.dart';
import 'package:flutter/material.dart';

class DisplayTimerData extends StatelessWidget {
  const DisplayTimerData({
    super.key,
    required this.timer,
  });

  final TimerNotifier timer;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Time between last two taps: ${formatDuration(timer.timeBwThrows)}'),
      Text(
          'Minimal time between two throws: ${formatDuration(timer.minTimeBetweenThrows)}'),
      Text(
          'Maximal time between two throws: ${formatDuration(timer.maxTimeBetweenThrows)}'),
    ]);
  }

  formatDuration(Duration? duration) {
    if (duration == null) return 'N/A';
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
        '${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}:'
        '${duration.inMilliseconds.remainder(1000).toString().padLeft(1, '0')}';
  }
}
