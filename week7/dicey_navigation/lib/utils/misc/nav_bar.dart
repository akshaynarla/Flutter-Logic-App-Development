import 'package:dicey_navigation/controllers/providers.dart';
import 'package:dicey_navigation/utils/buttons/undo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavBar extends ConsumerWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.heat_pump), label: 'HeatMap'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        BottomNavigationBarItem(icon: UndoButton(), label: 'Undo'),
      ],
      selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      onTap: (value) {
        ref.read(selectedIndexProvider.notifier).updateIndex(value);
        switch (value) {
          case 1:
            context.go('/visualization');
          case 2:
            context.go('/settings');
          default:
            context.go('/');
        }
      },
    );
  }
}
