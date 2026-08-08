import 'package:get/get.dart';
import '../features/app_shell/web_home_page.dart';

class AppRoutes {
  static const intro = '/intro';
  static const about = '/about';
  static const works = '/works';
  static const contact = '/contact';

  static final routes = [
    GetPage(
      name: intro,
      page: () => const WebHomePage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: about,
      page: () => const WebHomePage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: works,
      page: () => const WebHomePage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: contact,
      page: () => const WebHomePage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/',
      page: () => const WebHomePage(),
      transition: Transition.noTransition,
    ),
  ];
}
