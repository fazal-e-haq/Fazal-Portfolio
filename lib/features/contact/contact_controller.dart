import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ContactController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final nameError = RxnString();
  final emailError = RxnString();
  final messageError = RxnString();

  final _isSending = false.obs;
  bool get isSending => _isSending.value;

  void _setSending(bool value) {
    _isSending.value = value;
  }

  Future<void> sendEmail() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String message = messageController.text.trim();

    nameError.value = name.isEmpty ? 'Please enter your name' : null;
    emailError.value = email.isEmpty ? 'Please enter your email' : null;
    messageError.value = message.isEmpty ? 'Please enter a message' : null;

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      // Also show a generic snackbar for extra feedback
      Get.snackbar(
        'Missing Fields',
        'Please fill out all the required fields.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.9),
        colorText: Colors.white,
        margin: const EdgeInsets.all(24),
        borderRadius: 16,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return;
    }

    _setSending(true);

    // Simulate network request
    await Future.delayed(const Duration(milliseconds: 1500));

    _setSending(false);

    // Show premium animated success message
    Get.snackbar(
      'Message Sent Successfully!',
      'Thank you for getting in touch. I will reply to you soon.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.deepOrangeAccent.withValues(alpha: 0.9), // Match theme primary color
      colorText: Colors.white,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      borderRadius: 16,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 32),
      duration: const Duration(seconds: 4),
      forwardAnimationCurve: Curves.easeOutExpo,
      boxShadows: [
        BoxShadow(
          color: Colors.deepOrangeAccent.withValues(alpha: 0.2),
          blurRadius: 20,
          spreadRadius: 5,
        ),
      ],
    );

    // Clear form
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() => nameError.value = null);
    emailController.addListener(() => emailError.value = null);
    messageController.addListener(() => messageError.value = null);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
