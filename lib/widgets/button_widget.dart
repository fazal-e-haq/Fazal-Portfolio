import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/themes/theme.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
    this.onPressed,
    this.icon,
    required this.text,
    this.side,
    this.backgroundColor,
    this.elevation,
    this.textStyle,
    this.url,
    this.id,
    this.padding,
    this.color,
  });

  final void Function()? onPressed;
  final Widget text;
  final Color? backgroundColor;
  final WidgetStateProperty<BorderSide?>? side;
  final WidgetStateProperty<TextStyle?>? textStyle;
  final WidgetStateProperty<double?>? elevation;
  final Icon? icon;
  final String? url;
  final String? id;
  final EdgeInsets? padding;
  final Color? color;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _isHovered = false;
  bool _isPressed = false;

  Future<void> _launchUrl(String value) async {
    if (value.isEmpty) return;
    final Uri uri = (value.contains('@') && !value.startsWith('http'))
        ? Uri(scheme: 'mailto', path: value)
        : Uri.parse(value);

    try {
      await launchUrl(
        uri,
        mode: uri.scheme == 'mailto' ? LaunchMode.platformDefault : LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Error launching $uri: $e');
    }
  }

  void _handleTap() {
    if (widget.url != null) {
      _launchUrl(widget.url!);
    } else if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine the button's background color
    final bgColor = widget.color ?? widget.backgroundColor ?? AppColors.surface;
    
    // Smooth scaling: scale up slightly on hover, scale down slightly on press
    final double scale = _isPressed ? 0.95 : (_isHovered ? 1.05 : 1.0);
    
    // Z-axis effect: move up on hover, move down on press
    final double translateY = _isPressed ? 2.0 : (_isHovered ? -4.0 : 0.0);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _handleTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          transform: Matrix4.identity()..translateByDouble(0.0, translateY, 0.0, 1.0)..scaleByDouble(scale, scale, 1.0, 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(100),
            // When pressed, inner shadow (pressed state). When hovered, outer glow + larger shadow.
            boxShadow: AppColors.neumorphicShadows(
              isPressed: _isPressed,
              distance: _isPressed ? 2.0 : (_isHovered ? 12.0 : 6.0),
              blur: _isPressed ? 4.0 : (_isHovered ? 24.0 : 12.0),
              glowColor: _isHovered ? AppColors.primary : null,
            ),
            border: Border.all(
              color: _isHovered 
                  ? AppColors.primary.withValues(alpha: 0.5) 
                  : Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  IconTheme(
                    data: IconThemeData(
                      color: _isHovered ? AppColors.primary : Colors.white70,
                      size: 20,
                    ),
                    child: widget.icon!,
                  ),
                  const SizedBox(width: 12),
                ],
                DefaultTextStyle(
                  style: TextStyle(
                    color: _isHovered ? Colors.white : Colors.white70,
                    fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                    fontFamily: 'Poppins',
                    letterSpacing: 1.2,
                  ),
                  child: widget.text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
