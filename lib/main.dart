import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/smooth_scroll.dart';
import 'features/app_shell/web_home_page.dart';
import 'features/app_shell/navigation_controller.dart';
import 'features/contact/contact_controller.dart';
import 'features/project/project_controller.dart';
import 'features/splash/splash_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Controllers globally
  Get.put(SplashController());
  Get.put(NavigationController());
  Get.put(ContactController());
  Get.put(ProjectController());

  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fazal-E-Haq | Portfolio',
      debugShowCheckedModeBanner: false,
      darkTheme: mainTheme,
      theme: mainTheme,
      scrollBehavior: SmoothScrollBehavior(),

      // ── Dogstudio Full-Page Splash Reveal ─────
      home: Obx(() {
        final splashController = Get.find<SplashController>();
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1400),
          switchInCurve: const Cubic(0.77, 0.0, 0.175, 1.0), // Classic Dogstudio/Locomotive curve
          switchOutCurve: const Cubic(0.77, 0.0, 0.175, 1.0),
          // Ensure the outgoing SplashPage stays ON TOP of the incoming WebHomePage
          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                if (currentChild != null) currentChild, // Background (WebHomePage)
                ...previousChildren,                    // Foreground (SplashPage)
              ],
            );
          },
          transitionBuilder: (child, animation) {
            final isHomePage = child.key == const ValueKey('WebHomePage');

            if (isHomePage) {
              // The Home Page fades in gently as it is revealed.
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            } else {
              // The Splash Page — just hold it in place. 
              // The cinematic zoom inside SplashPage handles the exit visually.
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }
          },
          child: splashController.showIntro
              ? const WebHomePage(key: ValueKey('WebHomePage'))
              : const SplashPage(key: ValueKey('SplashPage')),
        );
      }),
    );
  }
}
