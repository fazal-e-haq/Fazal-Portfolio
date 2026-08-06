import 'package:web/web.dart' as web;

void downloadResume() {
  // Flutter Web serves assets relative to the 'assets' directory.
  // Since the file is in 'assets/' in pubspec, the URL is 'assets/assets/Fazal-Resume.pdf'
  const url = 'assets/assets/Fazal-Resume.pdf';

  final newTab = web.window.open(url, '_blank');

  // If popup blocker prevents it, fallback to same tab
  if (newTab == null) {
    web.window.location.assign(url);
  }
}