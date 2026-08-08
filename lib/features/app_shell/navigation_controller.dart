import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class NavigationController extends GetxController {
  final currentIndexRx = 0.obs;

  static const routes = [
    AppRoutes.intro,
    AppRoutes.about,
    AppRoutes.works,
    AppRoutes.contact,
  ];

  int get currentIndex => currentIndexRx.value;

  @override
  void onInit() {
    super.onInit();
    // Use addPostFrameCallback to ensure context is ready if needed,
    // or just run it immediately.
    syncRouteToIndex(Get.currentRoute);
  }

  void syncRouteToIndex(String currentRoute) {
    // Check if the current route matches one of our tab routes
    int index = routes.indexOf(currentRoute);
    if (index != -1 && currentIndexRx.value != index) {
      currentIndexRx.value = index;
    }
  }

  void setIndex(int index) {
    if (index >= 0 && index < routes.length) {
      if (currentIndexRx.value != index) {
        currentIndexRx.value = index;
        // Use Get.toNamed with preventDuplicates to add to history
        // without endless stacking of the identical routes if not needed
        Get.toNamed(routes[index], preventDuplicates: true);
      }
    }
  }
}
