import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App-wide colors for the Neumorphic design system
class AppColors {
  // Main background color (the "surface" in Neumorphism)
  static const Color background = Color(0xFF1A1A1A);
  
  // Primary accent color
  static const Color primary = Colors.blueAccent;
  
  // Text colors (As requested: dark black and low black)
  // NOTE: This will be very low contrast on the dark background.
  static const Color textMain = Colors.white; 
  static const Color textSecondary = Colors.grey; 
  
  // Shadow colors for Dark Neumorphism
  static const Color shadowDark = Colors.black;
  static final Color shadowLight = Colors.white.withValues(alpha: 0.05);
  
  // Input fields / Container inner colors
  static const Color surfaceInner = Color(0xFF151515);
}

/// The main theme configuration for the application
final ThemeData mainTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.background,
  
  // Define the default AppBar appearance
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  ),
  
  // Define the text appearance across the app
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.outfit(
      fontSize: 56,
      fontWeight: FontWeight.w900,
      color: AppColors.textMain,
      letterSpacing: -1.5,
    ),
    headlineMedium: GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textMain,
    ),
    headlineSmall: GoogleFonts.outfit(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.textMain,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 18,
      color: AppColors.textMain,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 16,
      color: AppColors.textSecondary,
      height: 1.5,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 13,
      color: AppColors.textSecondary,
    ),
  ),
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
    ),
  ),
  
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceInner,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: AppColors.textSecondary),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  ),
  
  dividerTheme: const DividerThemeData(
    color: Color(0xFF2A2A2A),
    thickness: 1,
    space: 30,
  ),
  
  useMaterial3: true,
);
