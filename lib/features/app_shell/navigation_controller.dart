import 'package:get/get.dart';
import 'scroll_coordinator_controller.dart';

/// Navigation state manager for section indexing.
/// Directly delegates to [ScrollCoordinatorController] for continuous vertical scroll,
/// without any unused browser URL routes.
class NavigationController extends GetxController {
  final currentIndexRx = 0.obs;

  int get currentIndex => currentIndexRx.value;

  void setIndex(int index) {
    if (index >= 0) {
      currentIndexRx.value = index;
      if (Get.isRegistered<ScrollCoordinatorController>()) {
        Get.find<ScrollCoordinatorController>().scrollToSection(index);
      }
    }
  }
}
