import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());

  int _currentIndex = 0;
  bool _isAnimatingToSection = false;

  int get currentIndex => _currentIndex;
  ScrollController get scrollController => _scrollController;
  List<GlobalKey> get sectionKeys => _sectionKeys;

  NavigationProvider() {
    _scrollController.addListener(_onScroll);
  }

  void scrollToSection(int pageIndex) {
    if (pageIndex < 0 || pageIndex >= _sectionKeys.length) return;
    final context = _sectionKeys[pageIndex].currentContext;
    if (context != null) {
      _isAnimatingToSection = true;
      setIndex(pageIndex);
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn,
      ).then((_) {
        // Wait slightly for momentum to settle before re-enabling scroll updates
        Future.delayed(const Duration(milliseconds: 100), () {
          _isAnimatingToSection = false;
        });
      });
    }
  }

  void _onScroll() {
    if (_isAnimatingToSection) return;
    if (!_scrollController.hasClients) return;

    final double screenHeight = _scrollController.position.viewportDimension;
    final double viewportCenter = screenHeight / 2;

    int activeIndex = 0;
    double minDistanceToCenter = double.infinity;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null && renderBox.hasSize) {
          final position = renderBox.localToGlobal(Offset.zero);
          final size = renderBox.size;

          final sectionTop = position.dy;
          final sectionBottom = sectionTop + size.height;

          // Check if this section spans the center of the viewport
          if (sectionTop <= viewportCenter && sectionBottom >= viewportCenter) {
            activeIndex = i;
            break;
          }

          // Fallback: find the section closest to the viewport center
          final sectionCenter = sectionTop + size.height / 2;
          final distanceToCenter = (sectionCenter - viewportCenter).abs();
          if (distanceToCenter < minDistanceToCenter) {
            minDistanceToCenter = distanceToCenter;
            activeIndex = i;
          }
        }
      }
    }

    setIndex(activeIndex);
  }

  void setIndex(int value) {
    if (_currentIndex == value) return;
    _currentIndex = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}
