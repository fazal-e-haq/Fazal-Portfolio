import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:web/web.dart' as web;

/// SplashController handles state management for the portfolio Splash Screen using GetX.
/// Controls the typewriter animation lifecycle and triggers the Locomotive / Dogstudio
/// style page transition upon completion.
class SplashController extends GetxController {
  // ── Reactive Observables (GetX State Management) ──────────────────────────

  /// Controls exit state when transitioning to WebHomePage.
  final RxBool _isExiting = false.obs;
  bool get isExiting => _isExiting.value;

  /// Flag indicating whether the splash is completed and main page is ready.
  final RxBool _showIntro = false.obs;
  bool get showIntro => _showIntro.value;

  static const _splashKey = 'has_seen_splash';

  @override
  void onInit() {
    super.onInit();
    // _checkIfSplashSeen();
  }

  void _checkIfSplashSeen() {
    if (kIsWeb) {
      final hasSeen = web.window.sessionStorage.getItem(_splashKey);
      if (hasSeen == 'true') {
        _isExiting.value = true;
        _showIntro.value = true;
      }
    }
  }

  /// Called by SplashTypingText when the typewriter animation completes.
  void onTypingFinished() async {
    // Wait 600ms for user to read text, then trigger Locomotive curtain reveal
    await Future.delayed(const Duration(milliseconds: 600));
    _markSplashSeenAndTransition();
  }

  /// Manual trigger to skip splash screen immediately if tapped anywhere.
  void skipSplash() {
    if (_showIntro.value) return;
    _markSplashSeenAndTransition();
  }

  void _markSplashSeenAndTransition() async {
    if (kIsWeb) {
      web.window.sessionStorage.setItem(_splashKey, 'true');
    }
    // Step 1: Trigger the slow cinematic zoom animation inside SplashPage
    _isExiting.value = true;

    // Step 2: Wait for the zoom to fill the screen with dark color
    // Slightly shorter than the 2800ms animation so the swap happens
    // while the screen is already fully dark — seamless handoff.
    await Future.delayed(const Duration(milliseconds: 2400));

    // Step 3: Now swap to WebHomePage (screen is already dark)
    _showIntro.value = true;
  }
}
