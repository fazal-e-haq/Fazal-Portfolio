import 'package:fazal_portfolio/presentation/widgets/neomorphism_information_card.dart';
import 'package:flutter/material.dart';
import 'package:fazal_portfolio/presentation/widgets/neumorphic_textfield.dart';
import 'package:fazal_portfolio/presentation/widgets/button_widget.dart';
import 'package:fazal_portfolio/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const double breakpoint = 800;

  bool isMobile(double width) => width < breakpoint;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = context.read<ContactProvider>();
    final mobile = isMobile(size.width);

    return Center(
      child: NeomorphismInformationCard(
        width: mobile ? size.width : size.width * 0.8,
        height: mobile ? null : size.height * 0.65,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mobile ? 3 : 20,
            vertical: mobile ? 10 : 20,
          ),
          child: mobile
              ? _MobileLayout(provider: provider)
              : _DesktopLayout(provider: provider),
        ),
      ),
    );
  }
}

// 📱 MOBILE LAYOUT (NO LABELS + COMPACT)

class _MobileLayout extends StatelessWidget {
  final ContactProvider provider;

  const _MobileLayout({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _Title(center: true),
        const SizedBox(height: 15),

        _Form(provider: provider, isMobile: true),
      ],
    );
  }
}

// 🖥️ DESKTOP LAYOUT (30% TEXT | 70% FORM)
class _DesktopLayout extends StatelessWidget {
  final ContactProvider provider;

  const _DesktopLayout({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 30% TEXT
        Expanded(flex: 3, child: _Title(center: false)),

        const SizedBox(width: 30),

        // 70% FORM
        Expanded(flex: 7, child: _Form(provider: provider, isMobile: false)),
      ],
    );
  }
}

// 🧠 TITLE

class _Title extends StatelessWidget {
  final bool center;

  const _Title({required this.center});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: center ? Alignment.center : Alignment.centerLeft,
      child: Text(
        'Got a Project\nin mind?',
        textAlign: center ? TextAlign.center : TextAlign.left,
        style: center
            ? Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: Colors.deepOrange)
            : Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: Colors.deepOrange),
      ),
    );
  }
}

// 🧾 FORM (RESPONSIVE + MOBILE LABEL REMOVAL)

class _Form extends StatelessWidget {
  final ContactProvider provider;
  final bool isMobile;

  const _Form({required this.provider, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // NAME + EMAIL
        isMobile
            ? Column(
                children: [
                  _input(provider.nameController, "Name"),
                  const SizedBox(height: 10),
                  _input(provider.emailController, "Email"),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _labeledInput(
                      "Your name",
                      "Name",
                      provider.nameController,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _labeledInput(
                      "Your email",
                      "Email",
                      provider.emailController,
                    ),
                  ),
                ],
              ),

        const SizedBox(height: 15),

        // MESSAGE (NO LABEL ON MOBILE)
        if (!isMobile) _label("Your Message"),
        if (!isMobile) const SizedBox(height: 8),

        NeumorphicTextField(
          hintText: 'Message',
          maxLines: 4,
          controller: provider.messageController,
        ),

        const SizedBox(height: 20),

        Consumer<ContactProvider>(
          builder: (context, provider, child) {
            return ButtonWidget(
              onPressed: provider.isSending ? null : provider.sendEmail,
              text: Text(provider.isSending ? 'Sending...' : 'Send Message'),
            );
          },
        ),
      ],
    );
  }
}

// 🔧 INPUT WITHOUT LABEL (MOBILE)

Widget _input(TextEditingController controller, String hint) {
  return NeumorphicTextField(hintText: hint, controller: controller);
}

// 🔧 INPUT WITH LABEL (DESKTOP ONLY)

Widget _labeledInput(
  String label,
  String hint,
  TextEditingController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _label(label),
      const SizedBox(height: 6),
      NeumorphicTextField(hintText: hint, controller: controller),
    ],
  );
}

// 🏷️ LABEL (DESKTOP ONLY)

Widget _label(String text) {
  return Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  );
}
