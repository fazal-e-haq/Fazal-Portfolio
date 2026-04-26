import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  // Constructor
  const ButtonWidget({
    super.key,
    required this.onPressed,
    this.icon,
    required this.child,
    this.side,
    this.backgroundColor,
    this.elevation,
    this.textStyle,
  });
  // Global variables
  final void Function()? onPressed;
  final Widget? child;
  final Color? backgroundColor;
  final WidgetStateProperty<BorderSide?>? side;
  final WidgetStateProperty<TextStyle?>? textStyle;
  final WidgetStateProperty<double?>? elevation;
  final Icon? icon;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        transform: _isHovered 
            ? (Matrix4.identity()..translate(0, -2)..scale(1.02)) 
            : Matrix4.identity(),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            backgroundColor: WidgetStatePropertyAll(
              _isHovered 
                  ? const Color(0xFF2A1E5C) // Lighter purple on hover
                  : const Color(0xFF1A1240) // Deep Slate Purple
            ),
            overlayColor: const WidgetStatePropertyAll(Colors.white10),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
            ),
          ),
          onPressed: widget.onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: 8),
              ],
              widget.child!,
            ],
          ),
        ),
      ),
    );
  }
}
