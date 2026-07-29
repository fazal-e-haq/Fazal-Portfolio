import 'package:flutter/material.dart';

/// AppSizes contains all responsive breakpoints and layout padding constants
/// for the portfolio, ensuring unified design across devices.
class AppSizes {
  // ── Responsive Breakpoints ───────────────────────────────────────────────
  
  /// Devices with width smaller than this are considered Mobile.
  static const double maxMobileWidth = 600.0;
  
  /// Devices with width between mobile and this are considered Tablet.
  /// Devices equal or larger are considered Desktop.
  static const double maxTabletWidth = 1100.0;

  // ── Margins & Padding ────────────────────────────────────────────────────
  
  /// Global horizontal padding for Mobile layouts.
  static const double paddingMobileHorizontal = 16.0;
  
  /// Global vertical padding for Mobile layouts.
  static const double paddingMobileVertical = 10.0;
  
  /// Global horizontal padding for Desktop & Tablet layouts.
  static const double paddingDesktopHorizontal = 64.0;
  
  /// Global vertical padding for Desktop & Tablet layouts.
  static const double paddingDesktopVertical = 20.0;

  // ── Helper Methods ───────────────────────────────────────────────────────
  
  /// Returns true if the current screen constraint is mobile.
  static bool isMobile(BoxConstraints constraints) =>
      constraints.maxWidth < maxMobileWidth;
      
  /// Returns true if the current screen constraint is tablet.
  static bool isTablet(BoxConstraints constraints) =>
      constraints.maxWidth >= maxMobileWidth && constraints.maxWidth < maxTabletWidth;
      
  /// Returns true if the current screen constraint is desktop.
  static bool isDesktop(BoxConstraints constraints) =>
      constraints.maxWidth >= maxTabletWidth;

  /// Get horizontal padding based on constraints
  static double getHorizontalPadding(BoxConstraints constraints) {
    if (isMobile(constraints)) return paddingMobileHorizontal;
    return paddingDesktopHorizontal;
  }

  /// Get vertical padding based on constraints
  static double getVerticalPadding(BoxConstraints constraints) {
    if (isMobile(constraints)) return paddingMobileVertical;
    return paddingDesktopVertical;
  }
}
