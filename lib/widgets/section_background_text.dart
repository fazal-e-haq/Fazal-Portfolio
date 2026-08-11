import 'package:flutter/material.dart';

class SectionBackgroundText extends StatefulWidget {
  final String text;

  const SectionBackgroundText({
    super.key,
    required this.text,
  });

  @override
  State<SectionBackgroundText> createState() => _SectionBackgroundTextState();
}

class _SectionBackgroundTextState extends State<SectionBackgroundText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // A subtle breathing/pulsing animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.02, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen constraints for responsiveness
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isUltrawide = width > 1600;

    return Center(
      child: IgnorePointer(
        child: RepaintBoundary(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: 'Unbounded',
                    fontSize: isUltrawide ? 600 : 400,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    letterSpacing: 20,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = isMobile ? 1.5 : (isUltrawide ? 4.0 : 3.0)
                      ..color = Colors.white.withValues(alpha: _animation.value),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
