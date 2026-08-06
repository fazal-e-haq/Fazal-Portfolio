import 'package:flutter/material.dart';
import 'package:fazal_portfolio/features/contact/contact_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  tearDown(() {
    Get.deleteAll();
  });

  testWidgets('contact controller ignores empty submissions', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));
    final controller = Get.put(ContactController());

    await controller.sendEmail();
    await tester.pumpAndSettle();

    expect(controller.isSending, isFalse);
    expect(controller.nameController.text, isEmpty);
    expect(controller.emailController.text, isEmpty);
    expect(controller.messageController.text, isEmpty);
  });
}
