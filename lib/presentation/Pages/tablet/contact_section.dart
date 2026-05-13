import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/info_card_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/neumorphic_textfield.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/presentation/widgets/responsive_text.dart';
import 'package:fazal_portfolio/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class TabletContactSection extends StatelessWidget {
  const TabletContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final contactProvider = context.read<ContactProvider>();

    return SizedBox(
      width: size.width,
      child: Center(
        child: InfoCardWidget(
          width: size.width * 0.9,
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool useVertical = constraints.maxWidth < 750;

              Widget textContent = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: useVertical ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  ResponsiveText(
                    'Got a Project in\nmind?',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: useVertical ? TextAlign.center : TextAlign.left,
                    minFontSize: 28,
                    maxFontSize: 45,
                  ),
                ],
              );

              Widget formContent = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: NeumorphicTextField(hintText: 'Name', controller: contactProvider.nameController)),
                      const SizedBox(width: 15),
                      Expanded(child: NeumorphicTextField(hintText: 'Email', controller: contactProvider.emailController)),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                          : const Text('Send Message'),
                      );
                    },
                  ),
                ],
              );

              if (useVertical) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      textContent,
                      const SizedBox(height: 30),
                      formContent,
                    ],
                  ),
                );
              } else {
                return Row(
                  children: [
                    Expanded(flex: 4, child: textContent),
                    const SizedBox(width: 30),
                    Expanded(flex: 6, child: formContent),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
