import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class SplashProvider extends ChangeNotifier {
  bool _showIntro = false;
  bool get showIntro => _showIntro;

  void init() {
    if (kIsWeb) {
      try {
        final hasSeenSplash = web.window.sessionStorage.getItem(
          'hasSeenSplash',
        );

        if (hasSeenSplash == null) {
          // First time opening browser tab/session → show splash
          _showIntro = false;
          web.window.sessionStorage.setItem('hasSeenSplash', 'true');
        } else {
          // Reload happened → skip splash
          _showIntro = true;
        }
      } catch (e) {
        // Safe fallback in case storage access is restricted or throws error
        _showIntro = false;
      }
    } else {
      // Non-web platforms (mobile/desktop) always show splash on startup
      _showIntro = false;
    }

    notifyListeners();
  }

  void setIntro() {
    _showIntro = true;
    notifyListeners();
  }
}
