import 'package:get/get.dart';

class ButtonController extends GetxController {
  final _hoverStates = <String, bool>{}.obs;
  final _pressStates = <String, bool>{}.obs;

  bool isHovered(String id) => _hoverStates[id] ?? false;
  bool isPressed(String id) => _pressStates[id] ?? false;

  void setHovered(String id, bool value) {
    if (_hoverStates[id] != value) {
      _hoverStates[id] = value;
    }
  }

  void setPressed(String id, bool value) {
    if (_pressStates[id] != value) {
      _pressStates[id] = value;
    }
  }
}
