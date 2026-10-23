import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/themes/theme.dart';
import '../sketch_painter.dart';
import 'button_controller.dart';

/// A hand-drawn sketch button featuring an organic wobbly pencil border (no straight lines),
/// animated 3D hover lift, and press feedback.
class SketchButton extends StatefulWidget {
  const SketchButton({
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
  State<SketchButton> createState() => _SketchButtonState();
}

class _SketchButtonState extends State<SketchButton> {
  late final ButtonController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<ButtonController>()
        ? Get.find<ButtonController>()
        : Get.put(ButtonController());
  }

  Future<void> _launchUrl(String value) async {
    if (value.isEmpty) return;
    final Uri uri = (value.contains('@') && !value.startsWith('http'))
        ? Uri(scheme: 'mailto', path: value)
        : Uri.parse(value);

    try {
      final isMailto = uri.scheme == 'mailto';
      if (isMailto) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return;
      }
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
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
    final String buttonId = widget.id ?? widget.text.hashCode.toString();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _controller.setHovered(buttonId, true),
      onExit: (_) => _controller.setHovered(buttonId, false),
      child: GestureDetector(
        onTapDown: (_) => _controller.setPressed(buttonId, true),
        onTapUp: (_) {
          _controller.setPressed(buttonId, false);
          _handleTap();
        },
        onTapCancel: () => _controller.setPressed(buttonId, false),
        child: Obx(() {
          final bool isHovered = _controller.isHovered(buttonId);
          final bool isPressed = _controller.isPressed(buttonId);

          return AnimatedSlide(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            offset: Offset(0, isPressed ? 0.04 : (isHovered ? -0.06 : 0)),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOutCubic,
              scale: isPressed ? 0.95 : (isHovered ? 1.05 : 1.0),
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                turns: isHovered ? -0.005 : 0.0,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: isHovered ? 1.0 : 0.0),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  builder: (context, zigzagVal, child) {
                    return CustomPaint(
                      painter: SketchBorderPainter(
                        color: widget.color ?? AppColors.textMain,
                        backgroundColor: widget.backgroundColor,
                        strokeWidth: 2.2,
                        borderRadius: 14.0,
                        wobble: 1.9,
                        seed: buttonId.hashCode.abs() % 50 + 1,
                        isHovered: isHovered,
                        zigzagProgress: zigzagVal,
                      ),
                      child: child,
                    );
                  },
                  child: Padding(
                    padding:
                        widget.padding ??
                        const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          widget.icon!,
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: DefaultTextStyle(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Patrick Hand',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain,
                            ),
                            child: widget.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Backward compatibility alias
typedef ButtonWidget = SketchButton;
