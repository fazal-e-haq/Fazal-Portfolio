import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

/// A high-performance VSync physics-driven momentum scroll engine (Lenis-style).
/// Replaces discrete mouse wheel jumps with a continuous differential equation
/// running on every display refresh frame (60Hz / 120Hz / 144Hz):
///
///   current += (target - current) * (1 - e^(-lambda * dt))
///
/// Key Features:
/// - Fast & responsive: tuned for brisk, effortless web scrolling
/// - Compounding momentum on rapid wheel spins (up to 1.4x velocity multiplier)
/// - Frame-rate independent: identical physical glide distance across 60Hz - 240Hz
/// - Dual physics modes: snappy fluid momentum for mouse wheels, responsive damping for trackpads
/// - Continuous VSync ticker: 0ms animation cancel hitches or restarts
/// - Zero CPU when idle: ticker stops automatically when target is reached
/// - Smooth keyboard navigation (Arrow Down/Up, Page Down/Up, Space, Home, End)
/// - Seamless sync with programmatic navigation (navbar clicks)
/// - Zero-overhead bypass on mobile / touch devices
class SmoothMouseScroll extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final double scrollSpeed;
  final double physicsResponsiveness; // Lambda decay coefficient (default 10.5)
  final bool enabled;

  const SmoothMouseScroll({
    super.key,
    required this.child,
    required this.scrollController,
    this.scrollSpeed = 195.0,
    this.physicsResponsiveness = 10.5,
    this.enabled = true,
  });

  @override
  State<SmoothMouseScroll> createState() => _SmoothMouseScrollState();
}

class _SmoothMouseScrollState extends State<SmoothMouseScroll>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double _currentOffset = 0.0;
  double _targetOffset = 0.0;
  Duration _lastElapsed = Duration.zero;
  bool _isWheelScrolling = false;
  double _activeLambda = 10.5;
  DateTime? _lastWheelTime;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    widget.scrollController.addListener(_onExternalScroll);
  }

  @override
  void didUpdateWidget(covariant SmoothMouseScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_onExternalScroll);
      widget.scrollController.addListener(_onExternalScroll);
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _focusNode.dispose();
    widget.scrollController.removeListener(_onExternalScroll);
    super.dispose();
  }

  /// Synchronize target with external scroll changes (e.g. navbar clicks)
  void _onExternalScroll() {
    if (_isWheelScrolling || !_ticker.isActive) {
      if (widget.scrollController.hasClients) {
        _currentOffset = widget.scrollController.offset;
        if (!_isWheelScrolling) {
          _targetOffset = _currentOffset;
        }
      }
    }
  }

  void _startTicker({required double lambda}) {
    _activeLambda = lambda;
    _lastElapsed = Duration.zero;
    _isWheelScrolling = true;
    if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  /// Continuous differential physics calculation on every VSync frame
  void _onTick(Duration elapsed) {
    if (!widget.scrollController.hasClients) {
      _ticker.stop();
      _isWheelScrolling = false;
      return;
    }

    final position = widget.scrollController.position;
    final double minExtent = position.minScrollExtent;
    final double maxExtent = position.maxScrollExtent;

    // Calculate delta time (dt) in seconds, clamped to avoid spiral on tab switch
    final double dt = _lastElapsed == Duration.zero
        ? 0.0166
        : ((elapsed - _lastElapsed).inMicroseconds / 1000000.0).clamp(0.001, 0.04);
    _lastElapsed = elapsed;

    // Frame-rate independent exponential decay factor
    final double decayFactor = 1.0 - math.exp(-_activeLambda * dt);
    final double diff = _targetOffset - _currentOffset;

    // Continuous position step
    _currentOffset += diff * decayFactor;

    // Stop ticker when target is reached within sub-pixel threshold
    if (diff.abs() < 0.25) {
      _currentOffset = _targetOffset;
      if (widget.scrollController.hasClients) {
        widget.scrollController.jumpTo(_currentOffset);
      }
      _ticker.stop();
      _isWheelScrolling = false;
      return;
    }

    if (widget.scrollController.hasClients) {
      widget.scrollController.jumpTo(_currentOffset.clamp(minExtent, maxExtent));
    }
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (!widget.enabled || !widget.scrollController.hasClients) return;

    if (event is PointerScrollEvent) {
      final controller = widget.scrollController;
      final position = controller.position;
      final double delta = event.scrollDelta.dy;
      if (delta == 0) return;

      final double minExtent = position.minScrollExtent;
      final double maxExtent = position.maxScrollExtent;

      // Sync if idle or diverged
      if (!_ticker.isActive) {
        _currentOffset = controller.offset;
        _targetOffset = _currentOffset;
      }

      // Detect precision trackpad vs notched physical mouse wheel
      final bool isTrackpad = event.kind == PointerDeviceKind.trackpad ||
          (delta.abs() < 18.0 && delta != delta.roundToDouble());

      if (isTrackpad) {
        // Trackpads have OS continuous curves: use responsive lambda with direct scaling
        _targetOffset = (_targetOffset + delta * 1.30).clamp(minExtent, maxExtent);
        _startTicker(lambda: 18.0);
      } else {
        // Physical mouse wheel: dynamic velocity boost on fast spinning
        final now = DateTime.now();
        double velocityMultiplier = 1.0;
        if (_lastWheelTime != null) {
          final int millisSinceLast =
              now.difference(_lastWheelTime!).inMilliseconds;
          if (millisSinceLast < 120) {
            velocityMultiplier = 1.35; // Rapid spin momentum boost
          } else if (millisSinceLast < 220) {
            velocityMultiplier = 1.15;
          }
        }
        _lastWheelTime = now;

        final double direction = delta > 0 ? 1.0 : -1.0;
        final double step = direction * widget.scrollSpeed * velocityMultiplier;

        _targetOffset = (_targetOffset + step).clamp(minExtent, maxExtent);
        _startTicker(lambda: widget.physicsResponsiveness);
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

    final position = widget.scrollController.position;
    final double viewportHeight = position.viewportDimension;
    final double minExtent = position.minScrollExtent;
    final double maxExtent = position.maxScrollExtent;

    if (!_ticker.isActive) {
      _currentOffset = widget.scrollController.offset;
      _targetOffset = _currentOffset;
    }

    double delta = 0.0;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowDown:
        delta = 130.0;
        break;
      case LogicalKeyboardKey.arrowUp:
        delta = -130.0;
        break;
      case LogicalKeyboardKey.pageDown:
        delta = viewportHeight * 0.90;
        break;
      case LogicalKeyboardKey.pageUp:
        delta = -viewportHeight * 0.90;
        break;
      case LogicalKeyboardKey.space:
        final bool isShiftPressed = HardwareKeyboard.instance.isShiftPressed;
        delta = (isShiftPressed ? -1.0 : 1.0) * (viewportHeight * 0.90);
        break;
      case LogicalKeyboardKey.home:
        _targetOffset = minExtent;
        _startTicker(lambda: 12.0);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.end:
        _targetOffset = maxExtent;
        _startTicker(lambda: 12.0);
        return KeyEventResult.handled;
      default:
        return KeyEventResult.ignored;
    }

    if (delta != 0.0) {
      _targetOffset = (_targetOffset + delta).clamp(minExtent, maxExtent);
      _startTicker(lambda: 11.5);
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
