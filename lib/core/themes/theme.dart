import 'package:flutter/material.dart';

/// App-wide colors and shadows for the Ultra-Premium Neumorphic design system
class AppColors {
  // Main Obsidian background color (Deep, sleek dark tone for true Neumorphism)
  static const Color background = Color(0xFF141518);

  // Surface colors for raised Neumorphic cards
  static const Color surface = Color(0xFF1A1C20);
  
  // Inner surface color for sunken input fields or depressed states
  static const Color surfaceInner = Color(0xFF111215);

  // Accent colors for dynamic highlights
  static const Color primary = Colors.deepOrangeAccent;
  static const Color secondary = Colors.blueAccent;

  // Text colors for crystal clear readability
  static const Color textMain = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textMuted = Colors.white38;

  // Shadow colors for Ultra-Premium 3D Dark Neumorphism
  static const Color shadowDark = Color(0xFF0B0C0E);
  static final Color shadowLight = Colors.white.withValues(alpha: 0.04);
  static final Color shadowGlow = Colors.deepOrange.withValues(alpha: 0.25);

  /// Helper method to generate top-tier 3D Neumorphic dual box shadows
  static List<BoxShadow> neumorphicShadows({
    bool isPressed = false,
    double distance = 6.0,
    double blur = 12.0,
    Color? glowColor,
  }) {
    if (isPressed) {
      return [
        BoxShadow(
          color: shadowDark.withValues(alpha: 0.8),
          offset: Offset(distance / 2, distance / 2),
          blurRadius: blur / 2,
        ),
      ];
    }

    return [
      // Deep Dark Shadow (Bottom-Right)
      BoxShadow(
        color: shadowDark,
        offset: Offset(distance, distance),
        blurRadius: blur,
        spreadRadius: 1.0,
      ),
      // Soft Ambient Light Highlight (Top-Left)
      BoxShadow(
        color: shadowLight,
        offset: Offset(-distance, -distance),
        blurRadius: blur,
        spreadRadius: 1.0,
      ),
      // Optional subtle ambient neon glow
      if (glowColor != null)
        BoxShadow(
          color: glowColor.withValues(alpha: 0.15),
          offset: const Offset(0, 0),
          blurRadius: blur * 2,
          spreadRadius: 2.0,
        ),
    ];
  }
}

/// The main theme configuration for the application
final ThemeData mainTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.surface,
  fontFamily: 'Poppins',

  // Define the default AppBar appearance
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  ),

  // Define typography across the app
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textMain,
      fontFamily: 'Unbounded',
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
      fontFamily: 'Unbounded',
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: AppColors.textSecondary,
      height: 1.6,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 13,
      color: AppColors.textSecondary,
      height: 1.6,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
      color: AppColors.textMuted,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceInner,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: AppColors.textMuted),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0xFF252830),
    thickness: 1,
    space: 30,
  ),

  useMaterial3: true,
);

