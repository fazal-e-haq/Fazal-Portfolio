/// Stub implementation of AnalyticsService for non-web environments (tests, VM).
class AnalyticsService {
  static void logEvent(String name, [Map<String, Object>? parameters]) {}

  static void logSectionView(String sectionName) {}

  static void logProjectClick(String projectTitle, String? url) {}

  static void logResumeDownload() {}

  static void logContactSubmit() {}
}
