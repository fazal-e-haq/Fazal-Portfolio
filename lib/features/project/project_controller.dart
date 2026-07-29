import 'package:get/get.dart';

class ProjectController extends GetxController {
  final _hoverStates = <String, bool>{}.obs;

  bool isHovered(String key) {
    return _hoverStates[key] ?? false;
  }

  void setHovered(String key, bool value) {
    if (_hoverStates[key] != value) {
      _hoverStates[key] = value;
    }
  }
}
