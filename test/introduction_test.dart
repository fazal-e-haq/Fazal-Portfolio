import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/features/introduction/introduction_section.dart';

void main() {
  tearDown(() {
    Get.deleteAll();
  });

  testWidgets('Renders Introduction hero initial state on desktop', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final scrollController = ScrollController();

    await tester.pumpWidget(
      GetMaterialApp(
        home: CupertinoPageScaffold(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Introduction(scrollController: scrollController),
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify HELLO watermark letters are rendered
    expect(find.text('H'), findsOneWidget);
    expect(find.text('E'), findsOneWidget);
    expect(find.text('L'), findsNWidgets(2));
    expect(find.text('O'), findsOneWidget);
    expect(find.text('I am'), findsOneWidget);

    // Verify uncropped image is present
    expect(find.byType(Image), findsOneWidget);

    // Verify scroll arrow indicator is visible on initial landing and SCROLL DOWN text is removed
    expect(find.text('SCROLL DOWN'), findsNothing);
    expect(find.byType(CustomPaint), findsWidgets);
  });

  testWidgets('Renders Introduction hero on mobile', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    final scrollController = ScrollController();

    await tester.pumpWidget(
      GetMaterialApp(
        home: CupertinoPageScaffold(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Introduction(scrollController: scrollController),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('H'), findsOneWidget);
    expect(find.text('E'), findsOneWidget);
    expect(find.text('L'), findsNWidgets(2));
    expect(find.text('O'), findsOneWidget);
    expect(find.text('I am'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Verify scroll arrow indicator is visible on mobile and SCROLL DOWN text is removed
    expect(find.text('SCROLL DOWN'), findsNothing);
    expect(find.byType(CustomPaint), findsWidgets);
  });

  testWidgets(
    'Scrolling into Intro section hides HELLO background text and shows I am content',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1440, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final scrollController = ScrollController();

      await tester.pumpWidget(
        GetMaterialApp(
          home: CupertinoPageScaffold(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Introduction(scrollController: scrollController),
                  const SizedBox(height: 1200),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      // At scroll 0, HELLO is visible and SCROLL DOWN text is removed
      expect(find.text('H'), findsOneWidget);
      expect(find.text('SCROLL DOWN'), findsNothing);

      // Scroll into the intro reading plateau
      scrollController.jumpTo(550);
      await tester.pump();
      await tester.pump(const Duration(seconds: 5)); // Allow slow typewriter animation to complete

      // HELLO letters and scroll prompt should now be completely hidden/removed
      expect(find.text('H'), findsNothing);
      expect(find.text('O'), findsNothing);
      expect(find.text('SCROLL DOWN'), findsNothing);

      // Intro greeting 'I am', 'FAZAL-E-HAQ', and 'Flutter Developer' role are present
      expect(find.text('I am'), findsOneWidget);
      expect(find.text('FAZAL-E-HAQ'), findsOneWidget);
      expect(find.text('Flutter Developer'), findsOneWidget);
      expect(find.textContaining('UI/UX Designer'), findsNothing);
      expect(
        find.text(
          'Who turns your ideas into fast, reliable mobile apps and websites that people genuinely love to use.',
        ),
        findsOneWidget,
      );

      // Verify stats: 1 | 3+ | 1.1k
      expect(find.text('1'), findsOneWidget);
      expect(find.text('Year Exp.'), findsOneWidget);
      expect(find.text('3+'), findsOneWidget);
      expect(find.text('Projects'), findsOneWidget);
      expect(find.text('1.1k'), findsOneWidget);
      expect(find.text('Followers'), findsOneWidget);
      expect(find.text('|'), findsNWidgets(2));

      // Verify CTA: Download Resume is present, View My Work is removed
      expect(find.text('Download Resume'), findsOneWidget);
      expect(find.text('View My Work'), findsNothing);
    },
  );
}
