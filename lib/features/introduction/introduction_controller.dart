import 'package:flutter/animation.dart';
import 'package:get/get.dart';

/// GetX Controller managing state for the Hero [Introduction] section.
///
/// Responsibilities:
/// 1. Tracks per-letter hover states for the background "HELLO" watermark.
/// 2. Tracks normalized scroll progress (`0.0` to `1.0`) for the hero stage.
/// 3. Provides clean, readable helper methods to compute animation phases
///    (watermark fade, portrait glide, and intro text reveal).
class IntroductionController extends GetxController {
  /// Reactive map of hover states keyed by element ID (e.g. `'hello_letter_0'`).
  final RxMap<String, bool> _hoverStates = <String, bool>{}.obs;

  /// Reactive normalized scroll progress (`0.0` at top of page, `1.0` when transition completes).
  final RxDouble scrollProgress = 0.0.obs;

  /// Returns `true` if the element with [key] is currently hovered.
  bool isHovered(String key) {
    return _hoverStates[key] ?? false;
  }

  /// Updates the hover state for the given [key].
  void setHovered(String key, bool value) {
    if (_hoverStates[key] != value) {
      _hoverStates[key] = value;
    }
  }

  /// Updates [scrollProgress] based on the current [scrollOffset] and [transitionDistance].
  void updateScrollProgress(double scrollOffset, double transitionDistance) {
    if (transitionDistance <= 0) return;
    final double next = (scrollOffset / transitionDistance).clamp(0.0, 1.0);
    if ((scrollProgress.value - next).abs() > 0.0005) {
      scrollProgress.value = next;
    }
  }

  /// Phase 1 (`0.0 -> 0.28`): Computes the opacity multiplier (`1.0 -> 0.0`)
  /// for the initial "HELLO" watermark so it smoothly disappears as the user scrolls down.
  double computeHelloFade(double progress) {
    final double raw = (progress / 0.28).clamp(0.0, 1.0);
    return 1.0 - Curves.easeOutCubic.transform(raw);
  }

  /// Phase 2 (`0.0 -> 0.48`): Computes the smooth eased progress (`0.0 -> 1.0`)
  /// for gliding the portrait from the center of the stage to its resting column.
  double computePortraitGlide(double progress) {
    final double raw = (progress / 0.48).clamp(0.0, 1.0);
    return Curves.easeInOutCubic.transform(raw);
  }

  /// Phase 3 (`0.26 -> 0.56`): Computes the smooth eased progress (`0.0 -> 1.0`)
  /// for revealing the intro details ("I am", "FAZAL-E-HAQ", "Flutter Developer", CTA buttons).
  double computeIntroReveal(double progress) {
    final double raw = ((progress - 0.26) / 0.30).clamp(0.0, 1.0);
    return Curves.easeOutCubic.transform(raw);
  }
}
