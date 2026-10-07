import 'package:flutter/material.dart';

/// App-wide colors for the Pencil Sketch / Brutalist Theme
class AppColors {
  // Pure White and Bold Yellow background
  static const Color background = Color(0xFFFFFFFF);
  
  // Solid Yellow accent
  static const Color primary = Color(0xFFFFD700); // Vibrant Yellow
  static const Color secondary = Color(0xFFFFD700); // Yellow (No other colors allowed)

  // Surface colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceInner = Color(0xFFF9F9F9);

  // Pure Black for text and borders
  static const Color textMain = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF000000);
  static const Color textMuted = Color(0xFF000000); // Keep everything black

  // Hard black shadow for the sketch/brutalist look
  static const Color shadowDark = Color(0xFF000000);

  /// Generates a sharp, hard-edged offset shadow typical of pencil/brutalist sketches
  static List<BoxShadow> sketchShadows({
    bool isPressed = false,
    double distance = 6.0,
  }) {
    if (isPressed) {
      return [
        const BoxShadow(
          color: AppColors.shadowDark,
          offset: Offset(0, 0),
          blurRadius: 0,
        ),
      ];
    }

    return [
      BoxShadow(
        color: AppColors.shadowDark,
        offset: Offset(distance, distance),
        blurRadius: 0, // NO blur = hard sketch look
        spreadRadius: 1.0,
      ),
    ];
  }
}

/// The main theme configuration for the application (Sketch Mode)
final ThemeData mainTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.surface,
  fontFamily: 'Unbounded', // Bolder, raw font

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w900,
      color: AppColors.textMain,
      fontFamily: 'Unbounded',
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: AppColors.textMain,
      fontFamily: 'Unbounded',
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: AppColors.textMain,
      height: 1.6,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 13,
      color: AppColors.textMain,
      height: 1.6,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
      color: AppColors.textMain,
      fontWeight: FontWeight.w500,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textMain,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // Sharp corners for sketch look
        side: const BorderSide(color: AppColors.textMain, width: 2), // Black outline
      ),
      elevation: 0,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.textMain, width: 2),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.textMain, width: 2),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.textMain, width: 3), // Thicker on focus
    ),
    hintStyle: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  ),

  dividerTheme: const DividerThemeData(
    color: AppColors.textMain,
    thickness: 2,
    space: 30,
  ),

  useMaterial3: true,
);
