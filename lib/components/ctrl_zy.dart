import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinesNotifier extends StateNotifier<List<List<Offset>>> {
  LinesNotifier() : super([]);

  int _currentIndex = -1;
  List<Offset> _currentLine = [];
  List<List<Offset>> _linesHistory = [];
  List<List<Offset>> _redoHistory = [];

  bool get canUndo => _currentIndex >= 0;
  bool get canRedo => _redoHistory.isNotEmpty; 

  void startLine(Offset point) {
    _redoHistory.clear(); 
    if (_currentIndex < _linesHistory.length - 1) {
      _linesHistory = _linesHistory.sublist(0, _currentIndex + 1);
    }
    _currentLine = [point];
    _linesHistory.add(List.from(_currentLine));
    _currentIndex = _linesHistory.length - 1;
    state = List.from(_linesHistory.sublist(0, _currentIndex + 1));
  }

  void addPoint(Offset point) {
    if (_currentLine.isNotEmpty) {
      _currentLine.add(point);
      _linesHistory[_currentIndex] = List.from(_currentLine);
      state = List.from(_linesHistory.sublist(0, _currentIndex + 1));
    }
  }

  void endLine() {
    _currentLine = [];
  }

  void undo() {
    if (canUndo) {
      _redoHistory.add(_linesHistory.removeAt(_currentIndex)); 
      _currentIndex--;
      state = List.from(_linesHistory.sublist(0, _currentIndex + 1));
    }
  }

  void redo() {
    if (canRedo) {
      _linesHistory.add(_redoHistory.removeLast());
      _currentIndex++;
      state = List.from(_linesHistory.sublist(0, _currentIndex + 1));
    }
  }

  List<List<Offset>> get currentLines => List.from(state);
}
