import 'package:fazal_portfolio/features/contact/contact_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.put(ContactController());
  });

  tearDown(() {
    Get.deleteAll();
  });

  test('contact controller ignores empty submissions', () async {
    final controller = Get.find<ContactController>();

    await controller.sendEmail();

    expect(controller.isSending, isFalse);
    expect(controller.nameController.text, isEmpty);
    expect(controller.emailController.text, isEmpty);
    expect(controller.messageController.text, isEmpty);
  });
}
