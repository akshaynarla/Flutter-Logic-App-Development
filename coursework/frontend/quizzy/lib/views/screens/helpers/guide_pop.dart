import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// widget for guide button within the quiz --> for bottom navigation bar.
// this UI is different from the guide screen in home page
class GuidePop extends ConsumerWidget {
  const GuidePop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Shows the dialog when the widget is built instead of the screen.
    // necessary for overlay management
    // inspired from: https://www.flutteris.com/blog/en/addpostframecallback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOverlay(context, ref);
    });

    return const SizedBox.shrink();
  }

  void showOverlay(BuildContext context, WidgetRef ref) {
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.7,
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Positioned(
          top: MediaQuery.of(context).size.height * 0.25,
          left: MediaQuery.of(context).size.width * 0.1,
          child: Material(
            color: Colors.transparent,
            child: AlertDialog(
              title: const Text('Tips and guides for your quiz'),
              // in content: tips and guides is mentioned
              content: popupDialogText(),
              actions: [
                TextButton(
                  onPressed: () {
                    overlayEntry.remove();
                    // go back to the quiz page
                    context.go('/home/mode/init');
                  },
                  child: const Text('Continue the quiz!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }

  Column popupDialogText() {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: [
          Text(
            '0. You have to find the truth table equivalence considering 4 variables, P, Q, R and S',
            softWrap: true,
          ),
          Text(
            '1. This quiz has 10 tasks/questions of MCQ type',
            softWrap: true,
          ),
          Text('2. Select one of the 3 choices', softWrap: true),
          Text(
              '3. After selecting a choice, move to the next question by pressing "Next" button.',
              softWrap: true),
          Text(
              '4. In case of timed mode, you only get 45 seconds to answer before the quiz moves to next task automatically.',
              softWrap: true),
          Text(
              '5. All the best! You can close this dialog when you are ready to continue the quiz.',
              softWrap: true)
        ]);
  }
}
