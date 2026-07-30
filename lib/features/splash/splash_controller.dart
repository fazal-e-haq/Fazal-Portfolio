import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:web/web.dart' as web;

/// SplashController — Orchestrates the cinematic splash lifecycle.
///
/// Flow:
/// 1. Typing animation plays (headline → divider → subtitle)
/// 2. [onTypingFinished] is called → waits a beat → triggers zoom
/// 3. [startZoom] fires → SplashPage's AnimationController drives the zoom
/// 4. When zoom fills the screen with dark → [completeSplash] swaps to WebHomePage
class SplashController extends GetxController {
  // ── State ──────────────────────────────────────────────────────────────
  final RxBool _showIntro = false.obs;
  bool get showIntro => _showIntro.value;

  /// Callback that SplashPage sets so the controller can trigger the zoom
  /// animation without tight coupling.
  VoidCallback? onZoomStart;

  static const _splashKey = 'has_seen_splash';

  @override
  void onInit() {
    super.onInit();
    _checkIfSplashSeen();
  }

  void _checkIfSplashSeen() {
    if (kIsWeb) {
      final hasSeen = web.window.sessionStorage.getItem(_splashKey);
      if (hasSeen == 'true') {
        _showIntro.value = true;
      }
    }
  }

  /// Called by SplashTypingText when the typewriter animation completes.
  void onTypingFinished() async {
    // Brief pause so the user can read the completed text
    await Future.delayed(const Duration(milliseconds: 500));
    // Trigger the cinematic zoom
    onZoomStart?.call();
  }

  /// Called by SplashPage when the zoom animation is fully complete
  /// and the screen is guaranteed to be entirely covered in dark color.
  void completeSplash() {
    if (kIsWeb) {
      web.window.sessionStorage.setItem(_splashKey, 'true');
    }
    _showIntro.value = true;
  }
}
