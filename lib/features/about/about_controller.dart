import 'package:get/get.dart';

class AboutController extends GetxController {
  final _hoverStates = <String, bool>{}.obs;

  bool isHovered(String key) {
    return _hoverStates[key] ?? false;
  }

  void setHovered(String key, bool value) {
    if (_hoverStates[key] != value) {
      _hoverStates[key] = value;
    }
  }

  final selectedPerspective = 0.obs;

  void setPerspective(int index) {
    selectedPerspective.value = index;
  }

  final selectedTechCategory = 'All'.obs;

  void setTechCategory(String category) {
    selectedTechCategory.value = category;
  }
}
