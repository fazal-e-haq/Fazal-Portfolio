import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/constants/smooth_scroll.dart';
import 'routes/app_routes.dart';
import 'features/app_shell/navigation_controller.dart';
import 'features/contact/contact_controller.dart';
import 'features/project/project_controller.dart';
import 'features/about/about_controller.dart';
import 'features/introduction/introduction_controller.dart';
import 'widgets/button/button_controller.dart';
import 'widgets/inputs/textfield_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  // Initialize GetX Controllers globally at app startup
  Get.put(NavigationController());
  Get.put(ContactController());
  Get.put(ProjectController());
  Get.put(TextFieldController());
  Get.put(AboutController());
  Get.put(IntroductionController());
  Get.put(ButtonController());

  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fazal-e-Haq | Flutter Developer & Software Architect',
      debugShowCheckedModeBanner: false,
      darkTheme: mainTheme,
      theme: mainTheme,
      scrollBehavior: SmoothScrollBehavior(),
      builder: (context, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final double baseFontSize = screenWidth < 600
            ? 12.0
            : (screenWidth < 1100 ? 13.0 : 14.0);

        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Theme(
            data: mainTheme.copyWith(
              textTheme: mainTheme.textTheme.copyWith(
                bodyLarge: mainTheme.textTheme.bodyLarge?.copyWith(
                  fontSize: baseFontSize,
                ),
                bodyMedium: mainTheme.textTheme.bodyMedium?.copyWith(
                  fontSize: baseFontSize,
                ),
                bodySmall: mainTheme.textTheme.bodySmall?.copyWith(
                  fontSize: baseFontSize - 1.0,
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
      routingCallback: (routing) {
        if (routing != null && routing.current.isNotEmpty) {
          Get.find<NavigationController>().syncRouteToIndex(routing.current);
        }
      },
    );
  }
}
