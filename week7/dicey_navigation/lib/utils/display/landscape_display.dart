import 'package:dicey_navigation/utils/display/left_page_landscape.dart';
import 'package:dicey_navigation/utils/display/right_page_landscape.dart';
import 'package:flutter/material.dart';

class LandscapeDisplay extends StatelessWidget {
  const LandscapeDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const FittedBox(fit: BoxFit.contain, child: Text('Dicey!!')),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
      ),
      body: const Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LeftPageLandscape(),
            RightPageLandscape(),
          ]),
    );
  }
}
