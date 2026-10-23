import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class NavigationController extends GetxController {
  final currentIndexRx = 0.obs;

  static const routes = [
    AppRoutes.home,
    AppRoutes.about,
    AppRoutes.works,
    AppRoutes.contact,
  ];

  int get currentIndex => currentIndexRx.value;

  @override
  void onInit() {
    super.onInit();
    syncRouteToIndex(Get.currentRoute);
  }

  void syncRouteToIndex(String currentRoute) {
    if (currentRoute == '/intro') {
      currentRoute = AppRoutes.home;
    }
    final int index = routes.indexOf(currentRoute);
    if (index != -1 && currentIndexRx.value != index) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        currentIndexRx.value = index;
      });
    }
  }

  void setIndex(int index) {
    if (index >= 0 && index < routes.length) {
      if (currentIndexRx.value != index) {
        currentIndexRx.value = index;
        Get.toNamed(routes[index], preventDuplicates: true);
      }
    }
  }
}
