import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/analytics_service.dart';

class ScrollCoordinatorController extends GetxController {
  late final ScrollController scrollController;
  final RxInt activeSectionIndex = 0.obs;
  List<GlobalKey>? _currentKeys;
  bool _isFrameScheduled = false;

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
    if (!scrollController.hasClients || _isFrameScheduled) return;
    _isFrameScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFrameScheduled = false;
      if (!scrollController.hasClients) return;

      final viewport = scrollController.position.viewportDimension;
      if (viewport == 0) return;

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
        detectedIndex = (scrollController.offset / viewport).floor().clamp(
          0,
          3,
        );
      }

      if (detectedIndex >= 0 &&
          detectedIndex <= 3 &&
          activeSectionIndex.value != detectedIndex) {
        activeSectionIndex.value = detectedIndex;
        const sectionNames = ['intro', 'about', 'works', 'contact'];
        if (detectedIndex < sectionNames.length) {
          AnalyticsService.logSectionView(sectionNames[detectedIndex]);
        }
      }
    });
  }

  void scrollToSection(int index) {
    if (!scrollController.hasClients ||
        index < 0 ||
        _currentKeys == null ||
        index >= _currentKeys!.length) {
      return;
    }

    if (index == 0) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
      return;
    }

    final context = _currentKeys![index].currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null && box.hasSize) {
        final Offset globalPos = box.localToGlobal(Offset.zero);
        final double currentScrollOffset = scrollController.offset;

        // On desktop/tablet, the floating AppBar takes ~96px.
        // We ensure the section content starts safely below the AppBar (~116px from viewport top).
        // On mobile, the AppBar is null (BottomNavBar is used), so provide a clean 20px top margin.
        final mediaQuery = MediaQuery.maybeOf(context);
        final bool isMobile = mediaQuery != null
            ? mediaQuery.size.width < 800
            : box.size.width < 800;
        final double topAppBarOffset = isMobile ? 20.0 : 116.0;

        final double targetOffset =
            (currentScrollOffset + globalPos.dy - topAppBarOffset).clamp(
          0.0,
          scrollController.position.maxScrollExtent,
        );

        scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
        return;
      }
    }

    // Fallback
    double targetOffset = 0;
    final viewport = scrollController.position.viewportDimension;
    if (index == 1) targetOffset = viewport * 1.5;
    if (index == 2) targetOffset = viewport * 2.5;
    if (index == 3) targetOffset = viewport * 3.5;

    scrollController.animateTo(
      targetOffset.clamp(0.0, scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 700),
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
