import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A performance-optimized desktop web momentum scroll wrapper.
/// Intercepts discrete mouse wheel notch jumps and smoothly animates the
/// [ScrollController] using a fluid cubic deceleration physics curve (like Lenis).
///
/// Features:
/// - Compounding momentum on fast wheel flicking
/// - Precision trackpad pass-through with low-latency responsiveness
/// - Smooth keyboard navigation (Arrow Down/Up, Page Down/Up, Space, Home, End)
/// - Auto-sync with programmatic scrolls (e.g. navbar clicks)
/// - Zero-overhead bypass on mobile/touch screens
class SmoothMouseScroll extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final double scrollSpeed;
  final Duration animationDuration;
  final Curve curve;
  final bool enabled;

  const SmoothMouseScroll({
    super.key,
    required this.child,
    required this.scrollController,
    this.scrollSpeed = 135.0,
    this.animationDuration = const Duration(milliseconds: 380),
    this.curve = Curves.easeOutCubic,
    this.enabled = true,
  });

  @override
  State<SmoothMouseScroll> createState() => _SmoothMouseScrollState();
}

class _SmoothMouseScrollState extends State<SmoothMouseScroll> {
  double _futureScrollOffset = 0.0;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (!widget.enabled || !widget.scrollController.hasClients) return;

    if (event is PointerScrollEvent) {
      final controller = widget.scrollController;
      final position = controller.position;
      final double delta = event.scrollDelta.dy;
      if (delta == 0) return;

      final double currentOffset = controller.offset;

      // Sync future target if user was idle or programmatic scroll occurred
      if ((_futureScrollOffset - currentOffset).abs() > 300.0) {
        _futureScrollOffset = currentOffset;
      }

      // Check if this is a high-precision continuous gesture (e.g. Trackpad)
      final bool isTrackpad = event.kind == PointerDeviceKind.trackpad ||
          (delta.abs() < 18.0 && delta != delta.roundToDouble());

      if (isTrackpad) {
        // Trackpads already supply OS momentum curves; animate quickly with subtle damping
        _futureScrollOffset = (_futureScrollOffset + delta * 1.15).clamp(
          position.minScrollExtent,
          position.maxScrollExtent,
        );
        controller.animateTo(
          _futureScrollOffset,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutQuad,
        );
      } else {
        // Physical notched mouse wheel:
        // Provide authentic momentum physics with ease-out cubic deceleration curve
        final double direction = delta > 0 ? 1.0 : -1.0;
        final double step = direction * widget.scrollSpeed;

        _futureScrollOffset = (_futureScrollOffset + step).clamp(
          position.minScrollExtent,
          position.maxScrollExtent,
        );

        controller.animateTo(
          _futureScrollOffset,
          duration: widget.animationDuration,
          curve: widget.curve,
        );
      }
    }
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!widget.enabled || !widget.scrollController.hasClients) {
      return KeyEventResult.ignored;
    }

    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }

    final controller = widget.scrollController;
    final position = controller.position;
    final viewportHeight = position.viewportDimension;
    double delta = 0.0;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowDown:
        delta = 90.0;
        break;
      case LogicalKeyboardKey.arrowUp:
        delta = -90.0;
        break;
      case LogicalKeyboardKey.pageDown:
        delta = viewportHeight * 0.85;
        break;
      case LogicalKeyboardKey.pageUp:
        delta = -viewportHeight * 0.85;
        break;
      case LogicalKeyboardKey.space:
        final bool isShiftPressed =
            HardwareKeyboard.instance.isShiftPressed;
        delta = (isShiftPressed ? -1.0 : 1.0) * (viewportHeight * 0.85);
        break;
      case LogicalKeyboardKey.home:
        _futureScrollOffset = position.minScrollExtent;
        controller.animateTo(
          _futureScrollOffset,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
        return KeyEventResult.handled;
      case LogicalKeyboardKey.end:
        _futureScrollOffset = position.maxScrollExtent;
        controller.animateTo(
          _futureScrollOffset,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
        return KeyEventResult.handled;
      default:
        return KeyEventResult.ignored;
    }

    if (delta != 0.0) {
      final double currentOffset = controller.offset;
      if ((_futureScrollOffset - currentOffset).abs() > 300.0) {
        _futureScrollOffset = currentOffset;
      }

      _futureScrollOffset = (_futureScrollOffset + delta).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      );

      controller.animateTo(
        _futureScrollOffset,
        duration: widget.animationDuration,
        curve: widget.curve,
      );
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Listener(
        onPointerSignal: _onPointerSignal,
        child: widget.child,
      ),
    );
  }
}
