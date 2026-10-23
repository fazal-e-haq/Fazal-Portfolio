import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/analytics_service.dart';

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

  final selectedScopes = <String>{}.obs;

  void toggleScope(String scope) {
    if (selectedScopes.contains(scope)) {
      selectedScopes.remove(scope);
    } else {
      selectedScopes.add(scope);
    }
  }

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
      return;
    }

    AnalyticsService.logContactSubmit();
    _setSending(true);

    try {
      String? encodeQueryParameters(Map<String, String> params) {
        return params.entries
            .map(
              (MapEntry<String, String> e) =>
                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
            )
            .join('&');
      }

      final String scopesText = selectedScopes.isNotEmpty
          ? ' [${selectedScopes.join(', ')}]'
          : '';

      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'fazalehaq37405@gmail.com',
        query: encodeQueryParameters(<String, String>{
          'subject': 'Portfolio Dispatch$scopesText: from $name',
          'body':
              'Name: $name\nEmail: $email\nScope: ${selectedScopes.join(', ')}\n\nMessage:\n$message',
        }),
      );

      await launchUrl(emailUri, mode: LaunchMode.externalApplication);

      // Clear form
      nameController.clear();
      emailController.clear();
      messageController.clear();
      selectedScopes.clear();
    } catch (e) {
      // Removed error snackbar as requested
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
