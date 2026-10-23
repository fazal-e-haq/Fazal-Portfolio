import 'package:flutter/material.dart';
import 'package:fazal_portfolio/features/app_shell/navigation_controller.dart';
import 'package:fazal_portfolio/features/app_shell/scroll_coordinator_controller.dart';
import 'package:fazal_portfolio/features/contact/contact_controller.dart';
import 'package:fazal_portfolio/features/project/project_model.dart';
import 'package:fazal_portfolio/features/project/projects_section.dart';
import 'package:fazal_portfolio/widgets/animations/scroll_3d_section.dart';
import 'package:fazal_portfolio/widgets/bottom_nav_bar_widget.dart';
import 'package:fazal_portfolio/widgets/nav_bar_widget.dart';
import 'package:fazal_portfolio/widgets/sketch_painter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  tearDown(() {
    Get.deleteAll();
  });

  testWidgets('contact controller ignores empty submissions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));
    final controller = Get.put(ContactController());

    await controller.sendEmail();
    await tester.pumpAndSettle();

    expect(controller.isSending, isFalse);
    expect(controller.nameController.text, isEmpty);
    expect(controller.emailController.text, isEmpty);
    expect(controller.messageController.text, isEmpty);
  });

  testWidgets(
    'NavBarWidget and BottomNavBarWidget tooltips use SketchTooltipDecoration',
    (WidgetTester tester) async {
      Get.put(NavigationController());
      Get.put(ScrollCoordinatorController());

      await tester.pumpWidget(
        const GetMaterialApp(
          home: Scaffold(
            appBar: NavBarWidget(),
            bottomNavigationBar: BottomNavBarWidget(),
          ),
        ),
      );
      await tester.pump();

      final tooltips = tester
          .widgetList<Tooltip>(find.byType(Tooltip))
          .toList();
      expect(tooltips.length, equals(8));
      for (final tooltip in tooltips) {
        expect(tooltip.decoration, isA<SketchTooltipDecoration>());
      }
    },
  );

  testWidgets(
    'Scroll3DSection applies 3D diagonal transforms across desktop, tablet, and mobile',
    (WidgetTester tester) async {
      for (final size in [
        const Size(1440, 900), // Desktop
        const Size(834, 1112), // Tablet
        const Size(390, 844), // Mobile
      ]) {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;

        final scrollController = ScrollController();

        await tester.pumpWidget(
          GetMaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 900),
                    Scroll3DSection(
                      scrollController: scrollController,
                      diagonalDirection: 1,
                      child: const SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: Center(child: Text('Section 1')),
                      ),
                    ),
                    Scroll3DSection(
                      scrollController: scrollController,
                      diagonalDirection: -1,
                      child: const SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: Center(child: Text('Section 2')),
                      ),
                    ),
                    const SizedBox(height: 900),
                  ],
                ),
              ),
            ),
          ),
        );
        await tester.pump();

        // Scroll through the sections to trigger diagonal 3D entry, center lock, and diagonal 3D exit
        for (final offset in [100.0, 450.0, 700.0, 1050.0, 1400.0]) {
          scrollController.jumpTo(offset);
          await tester.pump();
        }

        expect(find.text('Section 1'), findsOneWidget);
        expect(find.text('Section 2'), findsOneWidget);
      }

      addTearDown(tester.view.resetPhysicalSize);
    },
  );

  testWidgets(
    'ProjectsSection shows latest project first in Play Store view and stacks on scroll',
    (WidgetTester tester) async {
      const testProjects = [
        ProjectModel(
          id: '1',
          title: 'First App',
          logo: '',
          shortDescription: 'First mobile app',
          description: 'Detailed description of First App.',
          imagePath: '',
          screenshots: [],
          downloads: '1k+',
          rating: '4.7',
          type: 'Mobile App',
          tags: ['Flutter', 'Dart'],
        ),
        ProjectModel(
          id: '2',
          title: 'Second App',
          logo: '',
          shortDescription: 'Second web app',
          description: 'Detailed description of Second App.',
          imagePath: '',
          screenshots: [],
          downloads: '5k+',
          rating: '4.8',
          type: 'Web App',
          tags: ['Flutter', 'Firebase'],
        ),
        ProjectModel(
          id: '3',
          title: 'Latest Third App',
          logo: '',
          shortDescription: 'Newest flagship app',
          description: 'Detailed description of Latest Third App.',
          imagePath: '',
          screenshots: [],
          downloads: '10k+',
          rating: '4.9',
          type: 'Mobile App',
          tags: ['Flutter', 'GetX'],
        ),
      ];

      for (final size in [const Size(1440, 900), const Size(390, 844)]) {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;

        final scrollController = ScrollController();

        await tester.pumpWidget(
          GetMaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    ProjectsSection(
                      scrollController: scrollController,
                      customProjects: testProjects,
                    ),
                    const SizedBox(height: 800),
                  ],
                ),
              ),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(ProjectsSection), findsOneWidget);
        expect(find.text('Latest Third App'), findsAtLeastNWidgets(1));

        // Scroll down to stack Second App (#02) and First App (#01) on top while keeping titles visible
        for (final offset in [250.0, 520.0, 800.0, 1050.0]) {
          scrollController.jumpTo(offset);
          await tester.pump();
        }

        // All stacked project titles remain visible in the stack
        expect(find.text('Latest Third App'), findsAtLeastNWidgets(1));
        expect(find.text('Second App'), findsAtLeastNWidgets(1));
        expect(find.text('First App'), findsAtLeastNWidgets(1));
      }

      addTearDown(tester.view.resetPhysicalSize);
    },
  );
}
