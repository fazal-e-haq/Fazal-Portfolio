import 'package:web/web.dart' as web;

void downloadResume() {
  final anchor = web.HTMLAnchorElement()
    ..href = 'assets/Resume.pdf'
    ..download = 'Fazal_Resume.pdf';

  anchor.click();
}
