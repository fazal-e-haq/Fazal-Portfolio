import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/themes/theme.dart';
import 'splash_controller.dart';
import 'widgets/splash_typing_text.dart';

/// SplashPage — Cinematic 60fps zoom-through portal.
///
/// Uses an explicit [AnimationController] for guaranteed 60fps rendering.
/// The zoom uses a custom cubic curve that starts very slowly (letting the
/// user appreciate the text), then accelerates exponentially — just like
/// a cinematic Dolly Zoom / Vertigo effect.
///
/// The text is dark on a primary-orange background. As the dark text zooms
/// in, it fills the entire viewport with darkness, creating a seamless
/// visual handoff to the dark-themed WebHomePage underneath.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _zoomController;
  late final Animation<double> _zoomScale;
  late final Animation<double> _zoomOpacity;
  late final SplashController _splashController;

  @override
  void initState() {
    super.initState();
    _splashController = Get.find<SplashController>();

    // ── Zoom Animation Controller ──────────────────────────────────────
    // 3 seconds total: ultra-smooth, cinematic, 60fps guaranteed.
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Custom curve: starts imperceptibly slow, then rockets forward.
    // This mimics a camera dolly-zoom / Hitchcock "Vertigo" push.
    // The first 40% of the timeline barely moves (scale 1→1.3),
    // the last 60% explodes (scale 1.3→80).
    _zoomScale = TweenSequence<double>([
      // Phase 1: Gentle breathe (0% → 35%) — scale 1.0 → 1.15
      // The user sees the text start to subtly grow. Builds tension.
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.15)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
      // Phase 2: Acceleration (35% → 65%) — scale 1.15 → 5.0
      // The zoom picks up speed. Text characters start filling the view.
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 5.0)
            .chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 30,
      ),
      // Phase 3: Explosion (65% → 100%) — scale 5.0 → 80.0
      // The dark letters completely consume the viewport.
      TweenSequenceItem(
        tween: Tween<double>(begin: 5.0, end: 80.0)
            .chain(CurveTween(curve: Curves.easeInQuart)),
        weight: 35,
      ),
    ]).animate(_zoomController);

    // Opacity stays at 1.0 for 85% of the zoom, then fades to 0.0 in the
    // last 15%. This ensures the dark text covers the screen completely
    // before we dissolve the splash, revealing the dark homepage beneath.
    _zoomOpacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 85,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
    ]).animate(_zoomController);

    // When the zoom finishes, swap to the home page
    _zoomController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _splashController.completeSplash();
      }
    });

    // Register the zoom trigger with the controller
    _splashController.onZoomStart = _startZoom;
  }

  void _startZoom() {
    if (mounted && !_zoomController.isAnimating) {
      _zoomController.forward();
    }
  }

  @override
  void dispose() {
    _splashController.onZoomStart = null;
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _zoomController,
          builder: (context, child) {
            return Opacity(
              opacity: _zoomOpacity.value,
              child: Transform.scale(
                scale: _zoomScale.value,
                child: child,
              ),
            );
          },
          child: const SplashTypingText(),
        ),
      ),
    );
  }
}
