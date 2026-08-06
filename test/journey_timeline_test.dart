import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/features/about/widgets/journey_timeline.dart';
import 'package:fazal_portfolio/features/about/about_controller.dart';

void main() {
  testWidgets('Test JourneyTimeline layout', (WidgetTester tester) async {
    Get.put(AboutController());
    
    // Pump the widget
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: JourneyTimeline(isMobile: false),
          ),
        ),
      ),
    );
    
    // Wait and catch exception
    final exception = tester.takeException();
    if (exception != null) {
      print("Exception was thrown: $exception");
    } else {
      print("No exception thrown!");
    }
  });
}
