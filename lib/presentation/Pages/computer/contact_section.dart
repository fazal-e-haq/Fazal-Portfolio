import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/neumorphic_textfield.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';
import 'package:fazal_portfolio/providers/contact_provider.dart';
import 'package:provider/provider.dart';

// This section allows visitors to send you a message or get in touch
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final contactProvider = context.read<ContactProvider>();

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.85,
          height: size.height * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side: Large call-to-action text
              const Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ResponsiveText(
                    'Got a Project in\nmind?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                    minFontSize: 30,
                    maxFontSize: 60,
                    scaleFactor: 0.05,
                  ),
                ),
              ),
              const SizedBox(width: 50),
              // Right side: The contact form
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Your name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 10),
                              NeumorphicTextField(hintText: 'Name', controller: contactProvider.nameController),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Your email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 10),
                              NeumorphicTextField(hintText: 'Email', controller: contactProvider.emailController),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Text('Your Message', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    NeumorphicTextField(hintText: 'Message', maxLines: 5, controller: contactProvider.messageController),
                    const SizedBox(height: 30),
                    Consumer<ContactProvider>(
                      builder: (context, provider, child) {
                        return ButtonWidget(
                          onPressed: provider.isSending ? null : () => provider.sendEmail(),
                          icon: provider.isSending 
                            ? null 
                            : const Icon(Icons.send, size: 18),
                          child: provider.isSending 
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('Send Message'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
