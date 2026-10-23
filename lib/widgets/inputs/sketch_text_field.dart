import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/themes/theme.dart';
import '../sketch_painter.dart';
import 'textfield_controller.dart';

/// A hand-drawn sketch style text input field.
/// Features an organic wobbly pencil border (no straight lines), focus highlight, and reactive error display.
class SketchTextField extends StatelessWidget {
  SketchTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.errorText,
    this.maxLines = 1,
  }) : id = hintText.replaceAll(' ', '_').toLowerCase() {
    final tf = Get.isRegistered<TextFieldController>()
        ? Get.find<TextFieldController>()
        : Get.put(TextFieldController());
    tf.initField(id);
  }

  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextEditingController? controller;
  final RxnString? errorText;
  final String id;

  @override
  Widget build(BuildContext context) {
    final bool isMultiline = maxLines > 1;
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
            final hasError =
                errorText?.value != null && errorText!.value!.isNotEmpty;
            final Color activeColor = hasError
                ? Colors.redAccent.shade700
                : (isActive ? AppColors.primary : AppColors.textMain);

            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              child: CustomPaint(
                painter: SketchBorderPainter(
                  color: activeColor,
                  strokeWidth: (isActive || hasError) ? 2.5 : 2.1,
                  borderRadius: 18.0,
                  wobble: 2.0,
                  seed: id.hashCode.abs() % 60 + 5,
                  isHovered: isActive,
                ),
                child: TextField(
                  controller: controller,
                  maxLines: maxLines,
                  focusNode: tfController.getFocusNode(id),
                  cursorColor: AppColors.primary,
                  style: const TextStyle(
                    fontFamily: 'Patrick Hand',
                    color: AppColors.textMain,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontFamily: 'Patrick Hand',
                      color: AppColors.textMain.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    prefixIcon: Padding(
                      padding: isMultiline
                          ? const EdgeInsets.only(
                              bottom: 80,
                              left: 16,
                              right: 8,
                            )
                          : const EdgeInsets.only(left: 16, right: 8),
                      child: Icon(icon, color: activeColor, size: 20),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: isMultiline ? 20 : 16,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        // Error message (safely rendered only if errorText is non-null)
        if (errorText != null)
          Obx(() {
            final error = errorText!.value;
            if (error == null || error.isEmpty) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Text(
                error,
                style: const TextStyle(
                  fontFamily: 'Patrick Hand',
                  color: Colors.redAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
      ],
    );
  }
}
