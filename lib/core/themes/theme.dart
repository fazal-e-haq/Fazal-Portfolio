import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme = ThemeData(
scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent,),
    textTheme: TextTheme(
    bodySmall: GoogleFonts.inter(
      color: Colors.grey.shade500,
      fontSize: 12,
      fontWeight: .w400,
    ),
    bodyMedium: GoogleFonts.inter(
      color: Colors.grey.shade500,
      fontSize: 15,
      fontWeight: .w600,
    ),
    bodyLarge: GoogleFonts.inter(
      color: Colors.grey.shade600,
      fontSize: 17,
      fontWeight: .w600,
    ),
    headlineSmall: GoogleFonts.inter(
      color: Colors.grey.shade600,
      fontSize: 20,
      fontWeight: .w600,
    ),
    headlineMedium: GoogleFonts.inter(
      color: Colors.grey.shade600,
      fontSize: 24,
      fontWeight: .w600,
    ),
    headlineLarge: GoogleFonts.inter(
      color: Colors.grey.shade600,
      fontSize: 32,
      fontWeight: .w600,
    ),
  ),
);
