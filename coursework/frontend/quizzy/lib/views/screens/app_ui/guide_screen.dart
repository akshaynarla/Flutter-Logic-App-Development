import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/buttons/grey_button.dart';

// Simple user guide, consists of fixed widget and scrollable image for instructions.
// all widgets related to guide screen is retained here.
// guide screen configured for both portrait and landscape.
class GuideScreen extends ConsumerWidget {
  const GuideScreen({super.key});

  static const List<String> guideTexts = [
    "Welcome to the home of Quizzy! Read through the red text carefully.",
    "Upon clicking 'New Session' button, select the mode you want to quiz in.",
    "Almost there. Just a step away now!",
    "Read the instructions in each image carefully",
    "Needed help during quiz and pressed 'App Guide'?",
    "End of quiz",
    "Review your performance!",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Column(children: <Widget>[
        fixedWidget(context),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: PageView.builder(
              itemCount: guideTexts.length,
              itemBuilder: (context, index) {
                return buildGuidePage(context, index);
              },
            ),
          ),
        ),
        const GreyButton(routeStr: '/home', buttonName: 'Home'),
      ]),
    );
  }

  Widget fixedWidget(BuildContext context) {
    return Column(
      children: [
        const Text('Quizzy!!',
            softWrap: true,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 24.0,
                fontWeight: FontWeight.bold)),
        const Text('A Propositional Logic Quiz App', softWrap: true),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
      ],
    );
  }

  Widget buildGuidePage(BuildContext context, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(guideTexts[index],
            softWrap: true,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          Expanded(
            child: Image.asset('assets/images/po/image$index.png',
                fit: BoxFit.cover),
          ),
        if (MediaQuery.of(context).orientation == Orientation.landscape)
          Expanded(
            flex: 2,
            child: Image.asset('assets/images/ls/ls_image$index.png',
                fit: BoxFit.cover),
          ),
      ],
    );
  }
}
