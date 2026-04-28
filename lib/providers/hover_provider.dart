import 'package:flutter/material.dart';

class HoverProvider extends ChangeNotifier {
  final Map<String, bool> _hoverStates = {};

  bool isHovered(String key) {
    return _hoverStates[key] ?? false;
  }

  void setHovered(String key, bool value) {
    if (_hoverStates[key] != value) {
      _hoverStates[key] = value;
      notifyListeners();
    }
  }
}
