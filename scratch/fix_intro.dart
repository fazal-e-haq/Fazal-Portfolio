import 'dart:io';

void main() {
  final file = File('lib/features/introduction/introduction_section.dart');
  String content = file.readAsStringSync();
  
  if (!content.contains("import 'package:get/get.dart';")) {
    content = content.replaceFirst("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:get/get.dart';\nimport '../app_shell/scroll_coordinator_controller.dart';");
  }

  // Replace AnimatedBuilder with Obx
  final builderRegex = RegExp(r'child: AnimatedBuilder\(\s*animation: scrollController,\s*builder: \(context, child\) \{([\s\S]*?)return Transform\.translate', dotAll: true);
  
  content = content.replaceFirstMapped(builderRegex, (match) {
    return '''child: Obx(() {
              double offset = 0.0;
              if (Get.isRegistered<ScrollCoordinatorController>()) {
                offset = Get.find<ScrollCoordinatorController>().scrollOffset.value;
              }

              final progress = (offset / screenHeight).clamp(0.0, 1.0);
              final smoothProgress = Curves.easeInOutCubic.transform(progress);
              final stickOffset = offset < screenHeight ? offset : screenHeight;

              return Transform.translate''';
  });

  // Since AnimatedBuilder has an extra `)` at the very bottom that we need to remove...
  // Wait, Obx uses `})` just like AnimatedBuilder!
  // AnimatedBuilder is: `})` (if there's no `child` property passed).
  // Did I pass `child` to AnimatedBuilder?
  // No, `builder: (context, child)` but no `child: ...` at the end of AnimatedBuilder in Introduction.
  
  file.writeAsStringSync(content);
}
