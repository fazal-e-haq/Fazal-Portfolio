import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/themes/theme.dart';
import 'splash_controller.dart';
import 'widgets/splash_typing_text.dart';

/// SplashPage — Neomorphic knockout portal effect.
/// Primary-colored background with dark neomorphic text.
/// The text zooms in slowly and cinematically, the dark color
/// fills the viewport, and seamlessly transitions to the dark home page.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: GestureDetector(
        onTap: controller.skipSplash,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Obx(() {
            return AnimatedScale(
              // Slow, cinematic zoom — takes its time
              duration: const Duration(milliseconds: 2800),
              // easeInQuart: starts very slow, then accelerates dramatically
              // This gives the user time to appreciate the text before it rushes away
              curve: Curves.easeInQuart,
              scale: controller.isExiting ? 60.0 : 1.0,
              child: const SplashTypingText(),
            );
          }),
        ),
      ),
    );
  }
}
