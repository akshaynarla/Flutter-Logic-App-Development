import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quizzy/controllers/route_provider.dart';
import 'package:quizzy/views/utils/screen_utils/scaffold_with_navigation_bar.dart';
import 'package:quizzy/views/utils/screen_utils/scaffold_with_navigation_rail.dart';

// Taken from "Code with Andrea" and modified as per the app's requirements
class ScaffoldWithNestedNavigation extends ConsumerWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.read(routerProvider);
    return LayoutBuilder(builder: (context, constraints) {
      // Check if the current route starts with '/home/mode/'
      var isHomeMode = goRouter.routeInformationProvider.value.uri.toString();

      if (!isHomeMode.contains('/home/mode/')) {
        return Scaffold(
          body: navigationShell,
        );
      } else if (MediaQuery.of(context).orientation == Orientation.portrait) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }
    });
  }
}
