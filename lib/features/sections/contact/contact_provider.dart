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

    final Uri emailLaunchUri = Uri.https('mail.google.com', '/mail/', {
      'view': 'cm',
      'fs': '1',
      'to': 'fazalehaq37405@gmail.com',
      'su': 'Portfolio Contact: $name',
      'body': 'Name: $name\nEmail: $email\n\nMessage:\n$message',
    });

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);

        nameController.clear();
        emailController.clear();
        messageController.clear();
      } else {
        debugPrint('Could not launch email client');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    } finally {
      _setSending(false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
