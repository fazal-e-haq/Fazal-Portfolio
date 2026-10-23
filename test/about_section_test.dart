import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/features/about/about_section.dart';
import 'package:fazal_portfolio/features/about/about_controller.dart';

void main() {
  tearDown(() {
    Get.deleteAll();
  });

  testWidgets('Test AboutSection layout on desktop', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    Get.put(AboutController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: AboutSection())),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(AboutSection), findsOneWidget);
    // Verify medium-length ribbon chips are rendered
    expect(
      find.text('Building cross-platform mobile and web apps'),
      findsOneWidget,
    );
    expect(
      find.text('Designing sleek, intuitive, user-friendly interfaces'),
      findsOneWidget,
    );
    expect(
      find.text('Turning raw ideas into launch-ready products'),
      findsOneWidget,
    );
    // Verify tech stack
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('Figma'), findsOneWidget);
    expect(find.text('Postman'), findsOneWidget);
    // Verify track record milestones
    expect(find.text('1+ Year'), findsOneWidget);
    expect(find.text('Hands-On Experience'), findsOneWidget);
    expect(find.text('3+ Apps'), findsOneWidget);
    expect(find.text('Successfully Released'), findsOneWidget);
    expect(find.text('1.1K+'), findsOneWidget);
    expect(find.text('Community Followers'), findsOneWidget);
  });

  testWidgets('Test AboutSection layout on mobile', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    Get.put(AboutController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: AboutSection())),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(AboutSection), findsOneWidget);
    expect(
      find.text('Building cross-platform mobile and web apps'),
      findsOneWidget,
    );
    // Verify tech stack neural network is rendered identically on mobile
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('1+ Year'), findsOneWidget);
    expect(find.text('Hands-On Experience'), findsOneWidget);
    expect(find.text('3+ Apps'), findsOneWidget);
    expect(find.text('1.1K+'), findsOneWidget);
  });
}
