import 'package:web/web.dart' as web;

void downloadResume() {
  const url = '/assets/Fazal-Resume.pdf';
  const fileName = 'Fazal-Resume.pdf';

  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = fileName
    ..style.display = 'none';

  // Attach to DOM (important for Safari + some mobile browsers)
  web.document.body?.append(anchor);

  try {
    anchor.click();
  } catch (_) {
    // ignore click errors, fallback below still applies
  }

  // Small delay ensures download attempt is triggered
  Future.delayed(const Duration(milliseconds: 200), () {
    anchor.remove();
  });

  // Fallback: if download is blocked, open in new tab
  Future.delayed(const Duration(milliseconds: 300), () {
    final fallback = web.window.open(url, '_blank');

    // If popup blocked or failed, nothing more we can do safely
    if (fallback == null) {
      // last-resort: replace current tab
      web.window.location.href = url;
    }
  });
}
