import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/presentation/pages/web_home_page.dart';
import 'package:fazal_portfolio/providers/button_widget_provider.dart';
import 'package:fazal_portfolio/providers/project_provider.dart';
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
  GoogleFonts.config.allowRuntimeFetching = true;

  // Start the application
  runApp(const MyPortfolio());
}

// This is the main widget for the entire app
class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider is used to manage state across the app
    return MultiProvider(
      providers: [
        // HoverProvider handles mouse hover effects for buttons/cards
        ChangeNotifierProvider(create: (_) => ButtonWidgetProvider()),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
        // NavigationProvider manages section scrolling logic
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
      ],
      child: MaterialApp(
        title: 'Fazal-E-Haq | Portfolio',
        debugShowCheckedModeBanner: false,
        themeAnimationCurve: Curves.easeOut,

        // Set the visual theme of the app (colors, fonts, etc.)
        darkTheme: mainTheme,
        theme: mainTheme,
        scrollBehavior: SmoothScrollBehavior(),
        // The first page to show when the app opens
        home: const WebHomePage(),
      ),
    );
  }
}
