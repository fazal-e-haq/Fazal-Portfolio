import 'package:fazal_portfolio/providers/button_widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// This widget creates a special interactive button with hover effects
class ButtonWidget extends StatelessWidget {
  // Constructor
  const ButtonWidget({
    super.key,
    this.onPressed, // What happens when you click the button
    this.icon, // Optional icon to show next to the text
    required this.text, // The text or content inside the button
    this.side,
    this.backgroundColor,
    this.elevation,
    this.textStyle,
    this.url, // If provided, clicking the button opens this website link
    this.id,
    this.padding,
    this.color,
  });

  // Global variables
  final void Function()? onPressed;
  final Text text;
  final Color? backgroundColor;
  final WidgetStateProperty<BorderSide?>? side;
  final WidgetStateProperty<TextStyle?>? textStyle;
  final WidgetStateProperty<double?>? elevation;
  final Icon? icon;
  final String? url;
  final String? id;
  final EdgeInsets? padding;
  final Color? color;

  // This helper function opens a website link when the button is clicked
  Future<void> _launchUrl(String value) async {
    if (value.isEmpty) return;

    final Uri uri;

    // detect email
    if (value.contains('@') && !value.startsWith('http')) {
      uri = Uri(scheme: 'mailto', path: value);
    } else {
      uri = Uri.parse(value);
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: uri.scheme == 'mailto'
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
      );
      if (!launched) {
        debugPrint('Could not launch $uri');
      }
    } catch (error) {
      debugPrint('Error launching $uri: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Generate a unique ID for this button to track hover state
    final String buttonId = id ?? text.hashCode.toString();

    return Consumer<ButtonWidgetProvider>(
      builder: (context, hoverProvider, childWidget) {
        // Check if the mouse is currently over this button
        bool isHovered = hoverProvider.isHovered(buttonId);

        return MouseRegion(
          // When the mouse enters the button area
          onEnter: (_) => hoverProvider.setHovered(buttonId, true),
          // When the mouse leaves the button area
          onExit: (_) => hoverProvider.setHovered(buttonId, false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: isHovered
                  ? [
                      // Soft shadows when hovered (makes it look "pressed" or "active")
                      BoxShadow(
                        offset: const Offset(2, 2),
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 5,
                      ),
                      BoxShadow(
                        offset: const Offset(-2, -2),
                        color: Colors.white.withValues(alpha: 0.03),
                        blurRadius: 5,
                      ),
                    ]
                  : [
                      // Deeper shadows when not hovered (makes it look "popped out")
                      BoxShadow(
                        offset: const Offset(2, 2),
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        offset: const Offset(-2, -2),
                        color: Colors.white.withValues(alpha: 0.03),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
            ),
            // Slightly move the button up and make it bigger when hovered
            transform: Matrix4.identity()
              ..translateByDouble(0, isHovered ? -3 : 0, 0, 1)
              ..scaleByDouble(
                isHovered ? 1.05 : 1.0,
                isHovered ? 1.05 : 1.0,
                1,
                1,
              ),

            child: ElevatedButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(
                  padding ??
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                backgroundColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
                shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                elevation: const WidgetStatePropertyAll(0),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              // If a URL is provided, open the link. Otherwise, call the onPressed function.
              onPressed: url != null ? () => _launchUrl(url!) : onPressed,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Show icon if one is provided
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: MediaQuery.of(context).size.width * 0.009),
                  ],
                  childWidget!,
                ],
              ),
            ),
          ),
        );
      },
      child: text,
    );
  }
}
