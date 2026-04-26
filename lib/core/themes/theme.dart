import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme = ThemeData(
  appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: TextTheme(
    bodySmall: GoogleFonts.poppins(fontSize: 13),
    bodyMedium: GoogleFonts.poppins(fontSize: 16),
    bodyLarge: GoogleFonts.poppins(fontSize: 19),
    headlineSmall: GoogleFonts.unbounded(fontSize: 22),
    headlineMedium: GoogleFonts.unbounded(fontSize: 25),
    headlineLarge: GoogleFonts.unbounded(fontSize: 28),
  ),
);
