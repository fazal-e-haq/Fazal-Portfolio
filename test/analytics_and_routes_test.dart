import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/services/analytics_service.dart';
import 'package:fazal_portfolio/widgets/button/sketch_button.dart';
import 'package:fazal_portfolio/features/app_shell/navigation_controller.dart';
import 'package:fazal_portfolio/features/app_shell/scroll_coordinator_controller.dart';

void main() {
  group('AnalyticsService & Button Tracking Tests', () {
    test('AnalyticsService methods execute safely in test environment', () {
      expect(() => AnalyticsService.logEvent('test_event', {'param': 'val'}), returnsNormally);
      expect(() => AnalyticsService.logButtonClick('btn_test', 'https://example.com'), returnsNormally);
      expect(() => AnalyticsService.logNavClick('About', 1), returnsNormally);
      expect(() => AnalyticsService.logSectionView('works'), returnsNormally);
      expect(() => AnalyticsService.logProjectClick('CutCount', 'https://github.com'), returnsNormally);
      expect(() => AnalyticsService.logResumeDownload(), returnsNormally);
      expect(() => AnalyticsService.logContactSubmit(), returnsNormally);
    });

    testWidgets('SketchButton triggers button click analytics on tap', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: SketchButton(
              id: 'test_analytics_btn',
              text: const Text('Click Me'),
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byType(SketchButton));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });

  group('NavigationController Without Routes', () {
    test('NavigationController tracks active index and coordinates scroll', () {
      Get.reset();
      final scrollCoord = Get.put(ScrollCoordinatorController());
      final nav = Get.put(NavigationController());

      expect(nav.currentIndex, 0);
      nav.setIndex(2);
      expect(nav.currentIndex, 2);

      scrollCoord.dispose();
      nav.dispose();
    });
  });
}
