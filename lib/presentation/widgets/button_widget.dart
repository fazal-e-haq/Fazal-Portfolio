import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fazal_portfolio/providers/hover_provider.dart';

// This widget creates a special interactive button with hover effects
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.onPressed, // What happens when you click the button
    this.icon, // Optional icon to show next to the text
    required this.child, // The text or content inside the button
    this.side,
    this.backgroundColor,
    this.elevation,
    this.textStyle,
    this.url, // If provided, clicking the button opens this website link
    this.id,
  });

  final void Function()? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final WidgetStateProperty<BorderSide?>? side;
  final WidgetStateProperty<TextStyle?>? textStyle;
  final WidgetStateProperty<double?>? elevation;
  final Icon? icon;
  final String? url;
  final String? id;

  // This helper function opens a website link when the button is clicked
  Future<void> _launchUrl() async {
    if (url != null) {
      final Uri uri = Uri.parse(url!);
      // Use externalApplication mode to ensure links open in a new tab/browser
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Generate a unique ID for this button to track hover state
    final String buttonId = id ?? child.hashCode.toString();
    
    return Consumer<HoverProvider>(
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
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            // Neumorphic decoration that changes when hovered
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
                        offset: const Offset(6, 6),
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 12,
                      ),
                      BoxShadow(
                        offset: const Offset(-6, -6),
                        color: Colors.white.withValues(alpha: 0.03),
                        blurRadius: 12,
                      ),
                    ],
            ),
            // Slightly move the button up and make it bigger when hovered
            transform: isHovered
                ? (Matrix4.identity()..translateByVector3(Vector3(0.0, -2.0, 0.0))..scaleByVector3(Vector3(1.02, 1.02, 1.02)))
                : Matrix4.identity(),
            child: ElevatedButton(
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
                shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                elevation: const WidgetStatePropertyAll(0),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
                ),
              ),
              // If a URL is provided, open the link. Otherwise, call the onPressed function.
              onPressed: url != null ? _launchUrl : onPressed,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Show icon if one is provided
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  childWidget!,
                ],
              ),
            ),
          ),
        );
      },
      child: child,
    );
  }
}
