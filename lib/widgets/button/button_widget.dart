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
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return;
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication, webOnlyWindowName: '_blank');
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
    final String buttonId = id ?? text.hashCode.toString();
    
    if (!Get.isRegistered<ButtonController>()) {
      Get.put(ButtonController());
    }
    final ButtonController controller = Get.find<ButtonController>();

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
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 1. Scribble secondary border
                  Positioned.fill(
                    child: Transform.rotate(
                      angle: 0.015,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.textMain.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // 2. Main outline box
                  Transform.rotate(
                    angle: -0.010,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Outline only!
                        border: Border.all(
                          color: AppColors.textMain,
                          width: 2.0,
                        ),
                      ),
                      child: Transform.rotate(
                        angle: 0.010, // counter rotate content
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
                                    data: const IconThemeData(
                                      color: AppColors.textMain,
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
                                  color: AppColors.textMain,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Nunito',
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
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
