import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollCoordinatorController extends GetxController {
  late final ScrollController scrollController;
  final RxInt activeSectionIndex = 0.obs;
  final RxDouble scrollOffset = 0.0.obs;
  List<GlobalKey>? _currentKeys;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void registerKeys(List<GlobalKey> keys) {
    _currentKeys = keys;
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final offset = scrollController.offset;
    final viewport = scrollController.position.viewportDimension;
    if (viewport == 0) return;

    final index = (offset / viewport).floor();
    
    // Defer state updates to avoid marking widgets dirty during the layout phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollOffset.value != offset) {
        scrollOffset.value = offset;
      }
      if (index >= 0 && index <= 3 && activeSectionIndex.value != index) {
        activeSectionIndex.value = index;
      }
    });
  }

  void scrollToSection(int index) {
    if (!scrollController.hasClients || index < 0 || _currentKeys == null || index >= _currentKeys!.length) return;
    
    final context = _currentKeys![index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // Fallback
      double targetOffset = 0;
      final viewport = scrollController.position.viewportDimension;
      if (index == 0) targetOffset = 0;
      if (index == 1) targetOffset = viewport * 2.3;
      if (index == 2) targetOffset = viewport * 3.3;
      if (index == 3) targetOffset = viewport * 4.3;

      scrollController.animateTo(
        targetOffset.clamp(0.0, scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}



