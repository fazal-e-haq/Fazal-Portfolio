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
import 'widgets/textfield/textfield_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Controllers globally
  Get.put(SplashController());
  Get.put(NavigationController());
  Get.put(ContactController());
  Get.put(ProjectController());
  Get.put(TextFieldController());

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

      // ── Splash → Home transition ──────────────────
      // The zoom animation inside SplashPage fills the entire screen
      // with dark color before completeSplash() is called.
      // By the time we swap, the viewport is already dark — seamless.
      home: Obx(() {
        final splashController = Get.find<SplashController>();
        return splashController.showIntro
            ? const WebHomePage()
            : const SplashPage();
      }),
    );
  }
}
