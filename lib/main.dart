import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/presentation/pages/splash_page.dart';
import 'package:fazal_portfolio/presentation/pages/web_home_page.dart';
import 'package:fazal_portfolio/providers/project_provider.dart';
import 'package:fazal_portfolio/providers/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fazal_portfolio/providers/contact_provider.dart';
import 'package:fazal_portfolio/providers/navigation_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/smooth_scroll.dart';

// This is the starting point of the application
Future<void> main() async {
  // Ensure that plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Enable runtime font fetching so GoogleFonts can download the required fonts at runtime.
  try {
    GoogleFonts.config.allowRuntimeFetching = true;
    await GoogleFonts.pendingFonts([
      GoogleFonts.poppins,
      GoogleFonts.unbounded,
      GoogleFonts.inter,
    ]).timeout(const Duration(seconds: 3));
  } catch (e) {
    debugPrint('Error prefetching fonts: $e');
  }

  // Start the application
  runApp(const MyPortfolio());
}

// This is the main widget for the entire app
class MyPortfolio extends StatefulWidget {
  const MyPortfolio({super.key});

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  late final SplashProvider splashProvider;
  @override
  void initState() {
    splashProvider = SplashProvider();
    splashProvider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // MultiProvider is used to manage state across the app
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactProvider()),
        // NavigationProvider manages section scrolling logic
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider<SplashProvider>.value(value: splashProvider),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Fazal-E-Haq | Portfolio',
            debugShowCheckedModeBanner: false,
            themeAnimationCurve: Curves.easeOut,

            // Set the visual theme of the app (colors, fonts, etc.)
            darkTheme: mainTheme,
            theme: mainTheme,
            scrollBehavior: SmoothScrollBehavior(),
            // The first page to show when the app opens
            home: context.watch<SplashProvider>().showIntro
                ? const WebHomePage()
                : const SplashPage(),
          );
        },
      ),
    );
  }
}
