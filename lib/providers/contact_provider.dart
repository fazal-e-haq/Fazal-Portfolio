import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  bool _isSending = false;
  bool get isSending => _isSending;

  void _setSending(bool value) {
    _isSending = value;
    notifyListeners();
  }

  Future<void> sendEmail() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String message = messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      // You could add validation logic here
      return;
    }

    _setSending(true);

    final String recipientEmail = 'fazalehaq37405@gmail.com';
    final String subject = 'Portfolio Contact: $name';
    final String body = 'Name: $name\nEmail: $email\n\nMessage:\n$message';

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      query: _encodeQueryParameters(<String, String>{
        'subject': subject,
        'body': body,
      }),
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
        // Optional: clear fields after success
        // nameController.clear();
        // emailController.clear();
        // messageController.clear();
      } else {
        debugPrint('Could not launch email client');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    } finally {
      _setSending(false);
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
