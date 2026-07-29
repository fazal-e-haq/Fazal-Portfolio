import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ResponsiveText extends StatelessWidget {
  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.isHeading = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final TextStyle? style;
  final bool isHeading;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    // If isHeading is true, ensure the font family is Unbounded
    // Otherwise, Poppins is used (either from theme or explicitly here)
    final TextStyle baseStyle = style ?? const TextStyle();
    final TextStyle finalStyle = baseStyle.copyWith(
      fontFamily: isHeading ? 'Unbounded' : (baseStyle.fontFamily ?? 'Poppins'),
    );

    return AutoSizeText(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
