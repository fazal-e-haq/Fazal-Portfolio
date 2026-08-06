import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/features/about/about_section.dart';
import 'package:fazal_portfolio/features/about/about_controller.dart';

void main() {
  testWidgets('Test AboutSection layout', (WidgetTester tester) async {
    Get.put(AboutController());
    
    // Pump the widget
    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(
          body: AboutSection(),
        ),
      ),
    );
    
    await tester.pumpAndSettle();
    
    expect(find.byType(AboutSection), findsOneWidget);
  });
}
