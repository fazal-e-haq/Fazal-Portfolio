import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController {
  // We use a map to store states for different text fields by a unique ID
  final RxMap<String, bool> _hoverStates = <String, bool>{}.obs;
  final RxMap<String, bool> _focusStates = <String, bool>{}.obs;
  final Map<String, FocusNode> _focusNodes = {};

  void initField(String id) {
    if (!_focusNodes.containsKey(id)) {
      _hoverStates[id] = false;
      _focusStates[id] = false;
      
      final focusNode = FocusNode();
      focusNode.addListener(() {
        _focusStates[id] = focusNode.hasFocus;
      });
      _focusNodes[id] = focusNode;
    }
  }

  void setHovered(String id, bool isHovered) {
    _hoverStates[id] = isHovered;
  }

  bool isHovered(String id) => _hoverStates[id] ?? false;
  bool isFocused(String id) => _focusStates[id] ?? false;
  FocusNode getFocusNode(String id) => _focusNodes[id]!;

  @override
  void onClose() {
    for (var node in _focusNodes.values) {
      node.dispose();
    }
    super.onClose();
  }
}
