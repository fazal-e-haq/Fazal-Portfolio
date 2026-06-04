import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  final PageController _pageController = PageController();

  int _currentIndex = 0;
  double _pageOffset = 0.0;

  int get currentIndex => _currentIndex;
  double get pageOffset => _pageOffset;

  PageController get pageController => _pageController;

  void scrollToSection(int pageIndex) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn,
      );
    }

    _setIndex(pageIndex);
  }

  void updateIndexFromScroll(int pageIndex) {
    _setIndex(pageIndex);
  }

  void updatePageOffset(double offset) {
    _pageOffset = offset;
    notifyListeners();
  }

  void _setIndex(int value) {
    if (_currentIndex == value) return;
    _currentIndex = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}