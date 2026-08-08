import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; // Add this import

import 'core/constants/smooth_scroll.dart';
import 'routes/app_routes.dart';
import 'features/app_shell/navigation_controller.dart';
import 'features/contact/contact_controller.dart';
import 'features/project/project_controller.dart';
import 'features/about/about_controller.dart';
import 'features/introduction/introduction_controller.dart';
import 'widgets/textfield/textfield_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // Use path URL strategy to remove # from web URLs

  // Initialize GetX Controllers globally
  Get.put(NavigationController());
  Get.put(ContactController());
  Get.put(ProjectController());
  Get.put(TextFieldController());
  Get.put(AboutController());
  Get.put(IntroductionController());

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
      builder: (context, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        // Responsive body text sizes: 12 mobile, 13 tablet, 14 desktop
        final double baseFontSize = screenWidth < 600 ? 12 : (screenWidth < 1100 ? 13 : 14);
        
        return Theme(
          data: mainTheme.copyWith(
            textTheme: mainTheme.textTheme.copyWith(
              bodyLarge: mainTheme.textTheme.bodyLarge?.copyWith(fontSize: baseFontSize),
              bodyMedium: mainTheme.textTheme.bodyMedium?.copyWith(fontSize: baseFontSize),
              bodySmall: mainTheme.textTheme.bodySmall?.copyWith(fontSize: baseFontSize - 1),
            ),
          ),
          child: child!,
        );
      },

      // Routing
      initialRoute: AppRoutes.intro,
      getPages: AppRoutes.routes,
      routingCallback: (routing) {
        if (routing != null && routing.current.isNotEmpty) {
          final navCtrl = Get.find<NavigationController>();
          navCtrl.syncRouteToIndex(routing.current);
        }
      },
    );
  }
}
