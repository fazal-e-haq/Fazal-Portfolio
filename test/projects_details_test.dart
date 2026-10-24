import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fazal_portfolio/core/constants/projects_details.dart';
import 'package:fazal_portfolio/features/project/widgets/sketch_project_card.dart';

void main() {
  group('Projects Data & Rating Verification', () {
    test('Projects list contains CutCount and CopyFlutter with "Not yet rated"', () {
      final projects = Projects().projects;
      expect(projects.length, 2);

      // Project 1: CutCount
      expect(projects[0].title, 'CutCount');
      expect(projects[0].rating, 'Not yet rated');
      expect(projects[0].type, 'Mobile App');

      // Project 2: CopyFlutter
      expect(projects[1].title, 'CopyFlutter');
      expect(projects[1].rating, 'Not yet rated');
      expect(projects[1].type, 'Web App');
    });
  });

  group('SketchProjectCard Simple Chip Verification', () {
    testWidgets('Renders simplified Project 1 chip and Not yet rated stat', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      final project1 = Projects().projects[0];

      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: SketchProjectCard(
              project: project1,
              isMobile: false,
              displayIndex: 1,
            ),
          ),
        ),
      );
      await tester.pump();

      // Verified: Simple "Project 1" chip rendered (not "PROJECT // #01")
      expect(find.text('Project 1'), findsOneWidget);
      expect(find.text('PROJECT // #01'), findsNothing);
      expect(find.text('CutCount'), findsOneWidget);
      expect(find.text('Not yet rated'), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('Renders simplified Project 2 chip for CopyFlutter', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      final project2 = Projects().projects[1];

      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: SketchProjectCard(
              project: project2,
              isMobile: false,
              displayIndex: 2,
            ),
          ),
        ),
      );
      await tester.pump();

      // Verified: Simple "Project 2" chip rendered
      expect(find.text('Project 2'), findsOneWidget);
      expect(find.text('PROJECT // #02'), findsNothing);
      expect(find.text('CopyFlutter'), findsOneWidget);
      expect(find.text('Not yet rated'), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
}
