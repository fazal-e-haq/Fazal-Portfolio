import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollCoordinatorController extends GetxController {
  late final ScrollController scrollController;
  final RxInt activeSectionIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final offset = scrollController.offset;
    final viewport = scrollController.position.viewportDimension;
    if (viewport == 0) return;

    // Very simple estimation of active section
    final index = (offset / viewport).floor();
    if (index >= 0 && index <= 3 && activeSectionIndex.value != index) {
      activeSectionIndex.value = index;
    }
  }

  void scrollToSection(int index) {
    if (!scrollController.hasClients) return;
    
    // Estimate scroll target based on average section heights
    // Intro is 200vh, others are roughly 100vh
    double targetOffset = 0;
    final viewport = scrollController.position.viewportDimension;
    
    if (index == 0) targetOffset = 0;
    if (index == 1) targetOffset = viewport * 2.3; // Intro (2vh) + Gap (0.3vh)
    if (index == 2) targetOffset = viewport * 3.3;
    if (index == 3) targetOffset = viewport * 4.3;

    scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}
