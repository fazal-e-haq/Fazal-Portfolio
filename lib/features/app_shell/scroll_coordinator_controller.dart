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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollOffset.value != offset) {
        scrollOffset.value = offset;
      }

      int detectedIndex = 0;
      if (_currentKeys != null) {
        for (int i = 0; i < _currentKeys!.length; i++) {
          final ctx = _currentKeys![i].currentContext;
          if (ctx != null) {
            final box = ctx.findRenderObject() as RenderBox?;
            if (box != null && box.hasSize) {
              final position = box.localToGlobal(Offset.zero);
              if (position.dy <= viewport * 0.45) {
                detectedIndex = i;
              }
            }
          }
        }
      } else {
        detectedIndex = (offset / viewport).floor().clamp(0, 3);
      }

      if (detectedIndex >= 0 && detectedIndex <= 3 && activeSectionIndex.value != detectedIndex) {
        activeSectionIndex.value = detectedIndex;
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



