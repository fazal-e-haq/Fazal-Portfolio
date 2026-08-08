import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/themes/theme.dart';
import 'button_controller.dart';

class ButtonWidget extends StatelessWidget {
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

  Future<void> _launchUrl(String value) async {
    if (value.isEmpty) return;
    final Uri uri = (value.contains('@') && !value.startsWith('http'))
        ? Uri(scheme: 'mailto', path: value)
        : Uri.parse(value);

    try {
      final isMailto = uri.scheme == 'mailto';
      if (isMailto) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
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
    if (url != null) {
      _launchUrl(url!);
    } else if (onPressed != null) {
      onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    // We expect 'id' to be provided for reliable state, but fallback to a static-like hash.
    final String buttonId = id ?? text.hashCode.toString();
    
    // Ensure the controller is registered
    if (!Get.isRegistered<ButtonController>()) {
      Get.put(ButtonController());
    }
    final ButtonController controller = Get.find<ButtonController>();

    final bgColor = color ?? backgroundColor ?? AppColors.surface;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => controller.setHovered(buttonId, true),
      onExit: (_) => controller.setHovered(buttonId, false),
      child: GestureDetector(
        onTapDown: (_) => controller.setPressed(buttonId, true),
        onTapUp: (_) {
          controller.setPressed(buttonId, false);
          _handleTap();
        },
        onTapCancel: () => controller.setPressed(buttonId, false),
        child: Obx(() {
          final bool isHovered = controller.isHovered(buttonId);
          final bool isPressed = controller.isPressed(buttonId);

          return AnimatedSlide(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            offset: Offset(0, isPressed ? 0.05 : (isHovered ? -0.05 : 0)),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              scale: isPressed ? 0.95 : (isHovered ? 1.05 : 1.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      isHovered ? AppColors.surfaceInner : bgColor,
                      bgColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: AppColors.neumorphicShadows(
                    isPressed: isPressed,
                    distance: isPressed ? 2.0 : (isHovered ? 15.0 : 6.0),
                    blur: isPressed ? 4.0 : (isHovered ? 30.0 : 12.0),
                    glowColor: isHovered ? AppColors.primary.withValues(alpha: 0.6) : null,
                  ),
                  border: Border.all(
                    color: isHovered 
                        ? AppColors.primary.withValues(alpha: 0.8) 
                        : Colors.white.withValues(alpha: 0.08),
                    width: isHovered ? 1.5 : 1.0,
                  ),
                ),
                child: Padding(
                  padding: padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          transform: Matrix4.translationValues(isHovered ? 4 : 0, 0, 0),
                          child: IconTheme(
                            data: IconThemeData(
                              color: isHovered ? AppColors.primary : Colors.white70,
                              size: 22,
                            ),
                            child: icon!,
                          ),
                        ),
                        const SizedBox(width: 14),
                      ],
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: isHovered ? Colors.white : Colors.white70,
                          fontWeight: isHovered ? FontWeight.w700 : FontWeight.w500,
                          fontFamily: 'Poppins',
                          letterSpacing: isHovered ? 2.0 : 1.2,
                          fontSize: 15,
                        ),
                        child: text,
                      ),
                    ],
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
