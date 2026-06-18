import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

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
