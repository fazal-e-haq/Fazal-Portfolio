import 'package:web/web.dart' as web;

void downloadResume() {
  const url = '/assets/Fazal-Resume.pdf';

  final newTab = web.window.open(url, '_blank');

  // If popup blocker prevents it, fallback to same tab
  if (newTab == null) {
    web.window.location.assign(url);
  }
}