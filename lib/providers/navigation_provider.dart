import 'package:flutter/material.dart';

/// A provider that manages navigation state for the portfolio.
/// 
/// This provider holds the [PageController] used to navigate between different
/// sections (Home, About, Projects, Contact) across desktop, tablet, and mobile views.
/// By moving the controller here, we can convert stateful home pages into
/// stateless widgets, improving code organization and state management.
class NavigationProvider extends ChangeNotifier {
  /// Controller for the [PageView] in home pages
  final PageController _pageController = PageController();

  /// Getter for the page controller
  PageController get pageController => _pageController;

  /// Navigates the [PageView] to the specified section index.
  /// 
  /// [pageIndex] is the index of the section to scroll to.
  /// The animation uses a premium [Curves.easeOutCubic] for a smooth feel.
  void scrollToSection(int pageIndex) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the provider is destroyed
    _pageController.dispose();
    super.dispose();
  }
}
