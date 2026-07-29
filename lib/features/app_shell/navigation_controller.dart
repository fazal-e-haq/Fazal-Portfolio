import 'package:get/get.dart';

class NavigationController extends GetxController {
  final currentIndexRx = 0.obs;

  int get currentIndex => currentIndexRx.value;

  void setIndex(int index) {
    currentIndexRx.value = index;
  }
}
