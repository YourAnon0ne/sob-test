import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinesNotifier extends StateNotifier<List<List<Offset>>> {
  LinesNotifier() : super([]);

  int _currentIndex = 0;
  List<Offset> _currentLine = [];
  List<List<Offset>> _linesHistory = [];

  void startLine(Offset point) {
    if (_currentIndex < _linesHistory.length - 1) {
      _linesHistory = _linesHistory.sublist(0, _currentIndex + 1);
    }
    _currentLine = [point];
    _linesHistory.add(_currentLine);
    _currentIndex = _linesHistory.length - 1;
    state = List.from(_linesHistory);
  }

  void addPoint(Offset point) {
    _currentLine.add(point);
    state = List.from(_linesHistory);
  }

  void endLine() {
    _currentLine = [];
  }

  void undo() {
    if (_currentIndex >= 0) {
      _currentIndex--;
      state = List.from(_linesHistory.sublist(0, _currentIndex + 1));
    }
  }

  void redo() {
    if (_currentIndex < _linesHistory.length - 1) {
      _currentIndex++;
      state = List.from(_linesHistory.sublist(0, _currentIndex + 1));
    }
  }

  List<List<Offset>> get currentLines => List.from(state);
}
