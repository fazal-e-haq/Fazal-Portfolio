import 'package:flutter/material.dart';

// This widget creates text that automatically changes size based on the screen width
class ResponsiveText extends StatelessWidget {
  // The text content to show
  final String data;

  // Smallest allowed font size
  final double minFontSize;
  // Largest allowed font size
  final double maxFontSize;
  // How much the text grows or shrinks as the screen width changes
  final double scaleFactor;

  // Optional styling (font weight, color, etc.)
  final TextStyle? style;
  // Text alignment (center, left, right)
  final TextAlign? textAlign;
  // Maximum number of lines before cutting off
  final int? maxLines;
  // How to show cut-off text (e.g., "...")
  final TextOverflow? overflow;

  // Custom scaling for specific screen types
  final double? desktopScaleFactor;
  final double? tabletScaleFactor;

  const ResponsiveText(
      this.data, {
        super.key,
        this.minFontSize = 14,
        this.maxFontSize = 28,
        this.scaleFactor = 0.02,
        this.desktopScaleFactor,
        this.tabletScaleFactor,
        this.style,
        this.textAlign,
        this.maxLines,
        this.overflow,
      });

  // This function calculates the correct font size for the current screen width
  double _getFontSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double appliedScale = scaleFactor;

    // Use specific scaling if provided for Desktop or Tablet
    if (width > 1000 && desktopScaleFactor != null) {
      appliedScale = desktopScaleFactor!;
    } else if (width > 600 && tabletScaleFactor != null) {
      appliedScale = tabletScaleFactor!;
    }

    // Multiply screen width by the scale factor, but keep it between min and max limits
    return (width * appliedScale).clamp(minFontSize, maxFontSize);
  }

  @override
  Widget build(BuildContext context) {
    // Get the calculated font size
    final fontSize = _getFontSize(context);

    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: (style ?? const TextStyle()).copyWith(
        fontSize: fontSize,
      ),
    );
  }
}