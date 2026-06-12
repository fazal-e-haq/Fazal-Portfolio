import 'package:web/web.dart' as web;

void downloadResume() {
  final anchor = web.HTMLAnchorElement()
    ..href = 'assets/Fazal-Resume.pdf'
    ..download = 'Fazal-Resume.pdf';

  anchor.click();
}
