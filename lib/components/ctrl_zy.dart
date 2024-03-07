import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinesNotifier extends StateNotifier<List<List<List<Offset>>>> {
  LinesNotifier() : super([[]]);

  int _currentIndex = 0;

  void addPoint(Offset point) {
    state = [
      ...state.take(_currentIndex + 1),
      [
        ...state[_currentIndex],
        if (state[_currentIndex].isNotEmpty && state[_currentIndex].last.isNotEmpty)
          [...state[_currentIndex].last, point]
        else
          [point]
      ]
    ];
    _currentIndex++;
  }

  void endDrawing() {
    state = [
      ...state.take(_currentIndex + 1),
      [...state[_currentIndex], []]
    ];
    _currentIndex++;
  }

  void undo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      state = [...state];
    }
  }

  void redo() {
    if (_currentIndex < state.length - 1) {
      _currentIndex++;
      state = [...state];
    }
  }

  List<List<Offset>> get currentLines => state[_currentIndex];
}
