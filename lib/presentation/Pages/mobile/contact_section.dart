import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/neumorphic_textfield.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';
import 'package:fazal_portfolio/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class MobileContactSection extends StatelessWidget {
  const MobileContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final contactProvider = context.read<ContactProvider>();

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: ResponsiveText(
                    'Get in touch',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    minFontSize: 24,
                    maxFontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                NeumorphicTextField(hintText: 'Name', controller: contactProvider.nameController),
                const SizedBox(height: 15),
                NeumorphicTextField(hintText: 'Email', controller: contactProvider.emailController),
                const SizedBox(height: 15),
                NeumorphicTextField(hintText: 'Message', maxLines: 4, controller: contactProvider.messageController),
                const SizedBox(height: 25),
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
                        : const Text('Send'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
