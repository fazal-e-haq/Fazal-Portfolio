import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Coordinates the vertical scroll progression and translates continuous scroll
/// metrics into normalized 3D spatial camera transforms and section milestones.
class ScrollCoordinatorController extends GetxController with GetSingleTickerProviderStateMixin {
  /// The global scroll controller used by the single continuous vertical viewport
  final ScrollController scrollController = ScrollController();

  /// Normalized scroll progress: 0.0 (Intro) -> 1.0 (About) -> 2.0 (Works) -> 3.0 (Contact)
  final RxDouble scrollProgress = 0.0.obs;

  /// Normalized overall scroll percentage (0.0 to 1.0)
  final RxDouble overallProgress = 0.0.obs;

  /// Current active section index (0: Intro, 1: About, 2: Works, 3: Contact)
  final RxInt activeSectionIndex = 0.obs;

  /// Real-time scroll velocity for momentum-based 3D inertia/warp effects
  final RxDouble velocity = 0.0.obs;

  /// Mouse parallax delta for hybrid 3D perspective shifts (-1.0 to 1.0)
  final Rx<Offset> mousePosition = Offset.zero.obs;

  double _lastScrollOffset = 0.0;
  DateTime _lastScrollTime = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final double maxScroll = scrollController.position.maxScrollExtent;
    final double offset = scrollController.offset;

    if (maxScroll > 0) {
      overallProgress.value = (offset / maxScroll).clamp(0.0, 1.0);
    }

    // Calculate instantaneous velocity for 3D distortion
    final now = DateTime.now();
    final elapsed = now.difference(_lastScrollTime).inMilliseconds;
    if (elapsed > 0) {
      final delta = offset - _lastScrollOffset;
      velocity.value = (delta / elapsed) * 10;
      _lastScrollOffset = offset;
      _lastScrollTime = now;
    }

    // 4 primary sections: index 0, 1, 2, 3
    final double viewportHeight = scrollController.position.viewportDimension;
    if (viewportHeight > 0) {
      final double progress = (offset / viewportHeight).clamp(0.0, 3.0);
      scrollProgress.value = progress;
      final int newIndex = progress.round().clamp(0, 3);
      if (activeSectionIndex.value != newIndex) {
        activeSectionIndex.value = newIndex;
      }
    }
  }

  /// Smoothly scrolls the entire 3D camera and 2D canvas to the target section
  Future<void> scrollToSection(int index, {Duration duration = const Duration(milliseconds: 900)}) async {
    if (!scrollController.hasClients) return;
    final double viewportHeight = scrollController.position.viewportDimension;
    final double targetOffset = (index * viewportHeight).clamp(0.0, scrollController.position.maxScrollExtent);

    await scrollController.animateTo(
      targetOffset,
      duration: duration,
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  /// Updates mouse cursor coordinates normalized from -1.0 to 1.0
  void updateMouseParallax(Offset localPosition, Size size) {
    if (size.width == 0 || size.height == 0) return;
    final double dx = ((localPosition.dx / size.width) - 0.5) * 2;
    final double dy = ((localPosition.dy / size.height) - 0.5) * 2;
    mousePosition.value = Offset(dx.clamp(-1.0, 1.0), dy.clamp(-1.0, 1.0));
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
