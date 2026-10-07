import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/core/themes/theme.dart';
import 'textfield_controller.dart';

class NeumorphicTextField extends StatelessWidget {
  NeumorphicTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.errorText,
    this.maxLines = 1,
  }) : id = hintText.replaceAll(' ', '_').toLowerCase() {
    Get.find<TextFieldController>().initField(id);
  }

  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextEditingController? controller;
  final RxnString? errorText;
  final String id;

  @override
  Widget build(BuildContext context) {
    final isMultiline = maxLines > 1;
    final tfController = Get.find<TextFieldController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          onEnter: (_) => tfController.setHovered(id, true),
          onExit: (_) => tfController.setHovered(id, false),
          child: Obx(() {
            final isHovered = tfController.isHovered(id);
            final isFocused = tfController.isFocused(id);
            final isActive = isHovered || isFocused;
            final currentError = errorText?.value;
            final hasError = currentError != null && currentError.isNotEmpty;
            
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                color: AppColors.surfaceInner,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: hasError 
                      ? Colors.redAccent.withValues(alpha: 0.6)
                      : (isActive 
                          ? AppColors.primary.withValues(alpha: 0.5) 
                          : AppColors.shadowDark.withValues(alpha: 0.2)),
                  width: (isActive || hasError) ? 1.5 : 1,
                ),
                boxShadow: [
                  // Subtle inner drop shadow for light mode sunken effect
                  BoxShadow(
                    color: AppColors.shadowDark.withValues(alpha: 0.4),
                    offset: const Offset(insetDistance, insetDistance),
                    blurRadius: insetBlur,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-insetDistance, -insetDistance),
                    blurRadius: insetBlur,
                  ),
                  if (isActive && !hasError)
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: TextField(
                controller: controller,
                maxLines: maxLines,
                focusNode: tfController.getFocusNode(id),
                cursorColor: AppColors.primary,
                style: const TextStyle(color: AppColors.textMain, fontSize: 15),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(color: AppColors.textMuted),
                  prefixIcon: Padding(
                    padding: isMultiline 
                        ? const EdgeInsets.only(bottom: 80, left: 16, right: 8)
                        : const EdgeInsets.only(left: 16, right: 8),
                    child: Icon(
                      icon, 
                      color: hasError 
                          ? Colors.redAccent 
                          : (isActive 
                              ? AppColors.primary 
                              : AppColors.textMuted),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
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
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  static const double insetDistance = 2.0;
  static const double insetBlur = 4.0;
}
