import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final nameError = RxnString();
  final emailError = RxnString();
  final messageError = RxnString();

  final _hoverStates = <String, bool>{}.obs;

  bool isHovered(String key) {
    return _hoverStates[key] ?? false;
  }

  void setHovered(String key, bool value) {
    if (_hoverStates[key] != value) {
      _hoverStates[key] = value;
    }
  }

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

    try {
      String? encodeQueryParameters(Map<String, String> params) {
        return params.entries
            .map((MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('&');
      }

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'fazal.e.haq216@gmail.com',
        query: encodeQueryParameters(<String, String>{
          'subject': 'Portfolio Contact: Message from $name',
          'body': 'Name: $name\nEmail: $email\n\nMessage:\n$message',
        }),
      );

      await launchUrl(emailUri, mode: LaunchMode.externalApplication);

      // Show premium animated success message
      Get.snackbar(
        'Gmail Opened!',
        'You can now review and send your message directly via Gmail.',
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
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open Gmail. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    } finally {
      _setSending(false);
    }
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
