import 'dart:convert';
import 'dart:js_interop';

@JS('logPortfolioEvent')
external void _logPortfolioEvent(
  JSString eventName, [
  JSString? eventParamsJson,
]);

/// Web implementation of [AnalyticsService] dispatching events to Firebase Analytics & gtag.
class AnalyticsService {
  static void logEvent(String name, [Map<String, Object>? parameters]) {
    try {
      final JSString? jsonParam = parameters != null
          ? jsonEncode(parameters).toJS
          : null;
      _logPortfolioEvent(name.toJS, jsonParam);
    } catch (_) {
      // Fail silently if analytics is blocked by client ad-blocker
    }
  }

  static void logSectionView(String sectionName) {
    logEvent('section_view', {'section_name': sectionName});
  }

  static void logProjectClick(String projectTitle, String? url) {
    logEvent('project_click', {
      'project_title': projectTitle,
      'project_url': url ?? '',
    });
  }

  static void logResumeDownload() {
    logEvent('resume_download', {'file_name': 'Fazal-Resume.pdf'});
  }

  static void logContactSubmit() {
    logEvent('contact_form_submit', {'action': 'email_intent'});
  }
}
