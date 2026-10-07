import 'package:flutter/material.dart';

/// App-wide colors and shadows for the Light Mode 3D Spatial design system
class AppColors {
  // Main Studio background color (Soft Pearl/Alabaster for a physical feel)
  static const Color background = Color(0xFFF3F5F7);

  // Surface colors for raised Glass/Acrylic cards
  static const Color surface = Color(0xFFFFFFFF);
  
  // Inner surface color for sunken input fields or depressed states
  static const Color surfaceInner = Color(0xFFE9ECEF);

  // Accent colors for dynamic highlights
  static const Color primary = Color(0xFFFF6E40); // Deep Orange Accent
  static const Color secondary = Color(0xFF448AFF); // Crisp Blue Accent

  // Text colors for high contrast in light mode
  static const Color textMain = Color(0xFF141518); // Deep Charcoal/Ink
  static const Color textSecondary = Color(0xFF5F6368); // Slate Gray
  static const Color textMuted = Color(0xFFA0AAB2); // Soft Gray

  // Shadow colors for Soft Ambient 3D Light Mode
  static const Color shadowDark = Color(0xFFD1D9E6); // Light grayish blue for depth
  static const Color shadowLight = Color(0xFFFFFFFF); // Pure white highlight
  static final Color shadowGlow = Color(0xFFFF6E40).withValues(alpha: 0.15);

  /// Helper method to generate top-tier 3D physical soft shadows
  static List<BoxShadow> neumorphicShadows({
    bool isPressed = false,
    double distance = 10.0,
    double blur = 20.0,
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
      // Soft ambient drop shadow for elevation (Bottom-Right)
      BoxShadow(
        color: shadowDark.withValues(alpha: 0.6),
        offset: Offset(distance, distance),
        blurRadius: blur,
        spreadRadius: 0.0,
      ),
      // Crisp white highlight for the edge (Top-Left)
      BoxShadow(
        color: shadowLight,
        offset: Offset(-distance, -distance),
        blurRadius: blur,
        spreadRadius: 0.0,
      ),
      // Optional subtle ambient color glow
      if (glowColor != null)
        BoxShadow(
          color: glowColor.withValues(alpha: 0.25),
          offset: const Offset(0, 4),
          blurRadius: blur * 1.5,
          spreadRadius: 1.0,
        ),
    ];
  }
}

/// The main theme configuration for the application (Light Mode)
final ThemeData mainTheme = ThemeData(
  brightness: Brightness.light,
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
      elevation: 0,
    ),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceInner,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: AppColors.textMuted),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0xFFE2E8F0),
    thickness: 1,
    space: 30,
  ),

  useMaterial3: true,
);
