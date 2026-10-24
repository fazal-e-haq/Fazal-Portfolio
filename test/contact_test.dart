import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/features/contact/contact_section.dart';
import 'package:fazal_portfolio/features/contact/contact_controller.dart';
import 'package:fazal_portfolio/widgets/inputs/textfield_controller.dart';

void main() {
  setUp(() {
    Get.put(ContactController());
    Get.put(TextFieldController());
  });

  tearDown(() {
    Get.deleteAll();
  });

  testWidgets('Renders ContactSection on desktop', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: ContactSection())),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(ContactSection), findsOneWidget);
    expect(find.text('Get in Touch'), findsOneWidget);
    expect(find.text('Send a Message'), findsOneWidget);
    expect(find.text('CONNECT ACROSS PLATFORMS'), findsOneWidget);
    expect(find.byTooltip('Freelancer'), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.briefcase_fill), findsOneWidget);
  });

  testWidgets('Renders ContactSection on mobile', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: ContactSection())),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(ContactSection), findsOneWidget);
    expect(find.text('Get in Touch'), findsOneWidget);
    expect(find.text('Send a Message'), findsOneWidget);
    expect(find.byTooltip('Freelancer'), findsOneWidget);
    expect(find.byIcon(CupertinoIcons.briefcase_fill), findsOneWidget);
  });
}
