// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiceHistoryNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  DiceHistoryNotifier(List<Map<String, dynamic>> initialState)
      : super(initialState);

  // bool get undoDisable => state.isEmpty;
  final List<Map<String, dynamic>> undoStack = [];
  final List<Map<String, dynamic>> redoStack = [];

  void add(Map<String, dynamic> diceState) {
    undoStack.clear();
    state = [...state, diceState];
  }

  Map<String, dynamic>? undo() {
    if (state.isNotEmpty) {
      final lastState = state.last;
      // undone element added here
      undoStack.add(lastState);
      state = List.from(state)..removeLast();
      return lastState;
    }
    return null;
  }

  Map<String, dynamic>? redo() {
    if (undoStack.isNotEmpty) {
      final nextState = undoStack.removeLast();
      // debugPrint('$nextState');
      // redo element added here
      redoStack.add(nextState);
      // add the element to state for access in undo
      state = [...state, nextState];
      return nextState;
    }
    return null;
  }
}
