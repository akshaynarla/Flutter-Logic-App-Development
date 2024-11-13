import 'package:flutter_riverpod/flutter_riverpod.dart';

// for selecting the bottom navigation bar item
class SelectedIndexNotifier extends StateNotifier<int> {
  SelectedIndexNotifier() : super(0);

  void updateIndex(int index) {
    state = index;
  }
}
