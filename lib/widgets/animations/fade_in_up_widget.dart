import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fazal_portfolio/features/app_shell/web_home_page.dart';

class FadeInUpWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;

  const FadeInUpWidget({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    // Setting a slow default duration as requested (2.5 seconds).
    // Using 10s is safe for performance but causes a bad user experience.
    // 2500ms provides that slow, elegant feel without frustrating the user.
    this.duration = const Duration(milliseconds: 3500),
    this.offset = 0.2,
  });

  @override
  State<FadeInUpWidget> createState() => _FadeInUpWidgetState();
}

class _FadeInUpWidgetState extends State<FadeInUpWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _offset = Tween<Offset>(
      begin: Offset(0, widget.offset),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _startAfterSplash();
  }

  /// Waits for the splash fade to finish, then starts with the configured delay.
  /// If splash is already done (e.g. returning to a tab), starts immediately.
  void _startAfterSplash() async {
    // Wait for splash to finish (instant if already completed)
    await WebHomePage.splashComplete.future;

    // Then apply the per-widget stagger delay
    if (!mounted) return;
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }

    if (mounted) _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FadeTransition and SlideTransition use GPU-composited layers
    // for maximum performance (120fps capable).
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}
