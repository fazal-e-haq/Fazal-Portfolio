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

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Scribble secondary border
                Positioned.fill(
                  child: Transform.rotate(
                    angle: -0.020,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.textMain.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),

                // Main box
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOutCubic,
                  top: isActive ? 2 : 0,
                  left: isActive ? 2 : 0,
                  right: isActive ? -2 : 0,
                  bottom: isActive ? -2 : 0,
                  child: Transform.rotate(
                    angle: 0.012,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Completely transparent
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.textMain,
                          width: (isActive || hasError) ? 2.5 : 2.0,
                        ),
                      ),
                      child: Transform.rotate(
                        angle: -0.012, // Counter rotate
                        child: TextField(
                          controller: controller,
                          maxLines: maxLines,
                          focusNode: tfController.getFocusNode(id),
                          cursorColor: AppColors.textMain,
                          style: const TextStyle(
                            color: AppColors.textMain, 
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: TextStyle(
                              color: AppColors.textMain.withValues(alpha: 0.5),
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: Padding(
                              padding: isMultiline 
                                  ? const EdgeInsets.only(bottom: 80, left: 16, right: 8)
                                  : const EdgeInsets.only(left: 16, right: 8),
                              child: Icon(
                                icon, 
                                color: AppColors.textMain,
                              ),
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24, 
                              vertical: isMultiline ? 24 : 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Invisible child to give Stack a size since Positioned.fill/AnimatedPositioned don't dictate size
                Opacity(
                  opacity: 0,
                  child: TextField(
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24, 
                        vertical: isMultiline ? 24 : 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        Obx(() {
          final currentError = errorText?.value;
          if (currentError != null && currentError.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                currentError,
                style: const TextStyle(
                  color: AppColors.textMain,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
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

