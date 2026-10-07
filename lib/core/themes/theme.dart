import 'package:flutter/material.dart';

/// App-wide colors for the Pencil Sketch / Brutalist Theme
class AppColors {
  // Yellowish white pencil paper background
  static const Color background = Color(0xFFFDF0D5);

  // Soft/low opacity black theme
  static const Color primary = Color(0xDD000000);
  static const Color secondary = Color(0xDD000000);

  // Surface colors (Fully transparent for outline theme)
  static const Color surface = Colors.transparent;
  static const Color surfaceInner = Colors.transparent;

  // Soft Black for text and borders
  static const Color textMain = Color(0xDD000000);
  static const Color textSecondary = Color(0xBB000000);
  static const Color textMuted = Color(0x99000000);

  // Hard black shadow for the sketch/brutalist look
  static const Color shadowDark = Color(0xFF000000);

  /// Generates no shadow (as requested for pure sketch outline theme)
  static List<BoxShadow> sketchShadows({
    bool isPressed = false,
    double distance = 6.0,
  }) {
    return [];
  }

  /// Legacy wrapper to fix compilation errors for older components.
  /// Returns empty list to enforce pure outline theme.
  static List<BoxShadow> neumorphicShadows({
    bool isPressed = false,
    double distance = 6.0,
    double blur = 12.0,
    Color? glowColor,
  }) {
    return [];
  }
}

/// The main theme configuration for the application (Sketch Mode)
final ThemeData mainTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.surface,
  fontFamily: 'Patrick Hand',

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
      fontFamily: 'Patrick Hand',
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: AppColors.textMain,
      fontFamily: 'Patrick Hand',
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Patrick Hand',
      fontSize: 14,
      color: AppColors.textMain,
      height: 1.6,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Patrick Hand',
      fontSize: 13,
      color: AppColors.textMain,
      height: 1.6,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Patrick Hand',
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
        borderRadius: BorderRadius.circular(16), // Sharp corners for sketch look
        side: const BorderSide(
          color: AppColors.textMain,
          width: 2,
        ), // Black outline
      ),
      elevation: 0,
    ),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.textMain, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.textMain, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        color: AppColors.textMain,
        width: 3,
      ), // Thicker on focus
    ),
    hintStyle: TextStyle(
      color: AppColors.textMain,
      fontWeight: FontWeight.bold,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  ),

  dividerTheme: const DividerThemeData(
    color: AppColors.textMain,
    thickness: 2,
    space: 30,
  ),

  useMaterial3: true,
);
