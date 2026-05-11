import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/presentation/Pages/web_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:fazal_portfolio/providers/hover_provider.dart';
import 'package:fazal_portfolio/providers/contact_provider.dart';

// This is the starting point of the application
Future<void> main() async {
  // Ensure that plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables from the .env file
  await dotenv.load(fileName: ".env");
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
        ChangeNotifierProvider(create: (_) => HoverProvider()),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Set the visual theme of the app (colors, fonts, etc.)
        darkTheme: mainTheme,
        theme: mainTheme,
        // The first page to show when the app opens
        home: const WebPage(),
      ),
    );
  }
}

