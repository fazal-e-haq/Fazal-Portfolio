import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/core/themes/theme.dart';
import 'package:fazal_portfolio/widgets/responsive_text.dart';
import 'textfield_controller.dart';

class NeumorphicTextField extends StatelessWidget {
  NeumorphicTextField({
    super.key,
    required this.label,
    required this.icon,
    this.textController,
    this.errorText,
    this.maxLines = 1,
  }) : id = label.replaceAll(' ', '_').toLowerCase() {
    Get.find<TextFieldController>().initField(id);
  }

  final String label;
  final IconData icon;
  final int maxLines;
  final TextEditingController? textController;
  final RxnString? errorText;
  final String id;

  static const double insetDistance = 4.0;
  static const double insetBlur = 8.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMultiline = maxLines > 1;
    final controller = Get.find<TextFieldController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        MouseRegion(
          onEnter: (_) => controller.setHovered(id, true),
          onExit: (_) => controller.setHovered(id, false),
          child: Obx(() {
            final isHovered = controller.isHovered(id);
            final isFocused = controller.isFocused(id);
            final isActive = isHovered || isFocused;
            final currentError = errorText?.value;
            final hasError = currentError != null && currentError.isNotEmpty;
            
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                color: AppColors.surfaceInner,
                borderRadius: BorderRadius.circular(isMultiline ? 32 : 100),
                border: Border.all(
                  color: hasError 
                      ? Colors.redAccent.withValues(alpha: 0.6)
                      : (isActive 
                          ? theme.primaryColor.withValues(alpha: 0.5) 
                          : Colors.white.withValues(alpha: 0.05)),
                  width: (isActive || hasError) ? 1.5 : 1,
                ),
                boxShadow: [
                  // Inner shadow simulation for depressed look
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.8),
                    offset: const Offset(insetDistance, insetDistance),
                    blurRadius: insetBlur,
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.03),
                    offset: const Offset(-insetDistance, -insetDistance),
                    blurRadius: insetBlur,
                  ),
                  // Outer glow when hovered or focused
                  if (isActive && !hasError)
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.15),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  if (hasError)
                    BoxShadow(
                      color: Colors.redAccent.withValues(alpha: 0.15),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: TextField(
                controller: textController,
                maxLines: maxLines,
                focusNode: controller.getFocusNode(id),
                cursorColor: theme.primaryColor,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Enter $label',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
                  prefixIcon: Padding(
                    padding: isMultiline 
                        ? const EdgeInsets.only(bottom: 80, left: 16, right: 8)
                        : const EdgeInsets.only(left: 16, right: 8),
                    child: Icon(
                      icon, 
                      color: hasError 
                          ? Colors.redAccent 
                          : (isActive 
                              ? theme.primaryColor 
                              : AppColors.primary.withValues(alpha: 0.5)),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isMultiline ? 32 : 100),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isMultiline ? 32 : 100),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isMultiline ? 32 : 100),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24, 
                    vertical: isMultiline ? 24 : 20,
                  ),
                ),
              ),
            );
          }),
        ),
        Obx(() {
          final currentError = errorText?.value;
          if (currentError != null && currentError.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Text(
                currentError,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
