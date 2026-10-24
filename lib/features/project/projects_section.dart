import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/projects_details.dart';
import '../../widgets/sketch_painter.dart';
import '../app_shell/scroll_coordinator_controller.dart';
import 'project_model.dart';
import 'widgets/sketch_project_card.dart';

/// Featured Works / Projects Section.
///
/// Architecture & Enhancements:
/// 1. Latest Project First: Reverses `Projects().projects` (`projects.reversed.toList()`)
///    so the last index (latest uploaded project) is displayed first upon entering the section.
/// 2. Large Play Store Width: Expands up to `1480px` wide for a full Play Store showcase view.
/// 3. Scroll-Driven Sticky Card Stack with Visible Titles:
///    - As the user scrolls down through the section, each subsequent project slides up from
///      below in 3D space and stacks on top of the previous card at `i * headerPeekHeight`.
///    - Every stacked card beneath keeps its top `headerPeekHeight` title bar (Logo + Title +
///      Short Description + Badge) 100% visible ("seenable title") at the top of the stack.
class ProjectsSection extends StatefulWidget {
  final ScrollController? scrollController;
  final List<ProjectModel>? customProjects;

  const ProjectsSection({
    super.key,
    this.scrollController,
    this.customProjects,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final GlobalKey _stackTrackKey = GlobalKey();

  ScrollController? _resolveScrollController() {
    if (widget.scrollController != null) {
      return widget.scrollController;
    }
    if (Get.isRegistered<ScrollCoordinatorController>()) {
      return Get.find<ScrollCoordinatorController>().scrollController;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveController = _resolveScrollController();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = AppSizes.isMobile(constraints);
        final bool isTablet = AppSizes.isTablet(constraints);
        final List<ProjectModel> rawProjects =
            widget.customProjects ?? Projects().projects;

        // Render projects in chronological order: Project 1 (CutCount) then Project 2 (CopyFlutter)
        final List<ProjectModel> orderedProjects = rawProjects;
        final int count = orderedProjects.length;

        final double headerPeekHeight = isMobile ? 64.0 : 74.0;
        final double cardHeight = isMobile ? 590.0 : 630.0;
        final double deckHeight = count > 0
            ? cardHeight + ((count - 1) * headerPeekHeight)
            : cardHeight;

        final double scrollPerCard = isMobile ? 420.0 : 480.0;
        final double extraScrollTrack = count > 1
            ? ((count - 1) * scrollPerCard + 140.0)
            : 0.0;
        final double totalTrackHeight = deckHeight + extraScrollTrack;

        final double horizontalPad = isMobile ? 16.0 : (isTablet ? 28.0 : 40.0);

        // When only 1 project is featured (CutCount), render a clean, direct, butter-smooth view
        if (count == 1) {
          final ProjectModel project = orderedProjects.first;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1480),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPad),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SketchSectionHeader(
                      tag: '02 // FEATURED WORK',
                      title: 'Featured Project',
                      subtitle:
                          'A high-performance Flutter mobile app built with clean architecture, smooth offline support, and thoughtful engineering.',
                      isMobile: isMobile,
                      seed: 23,
                    ),
                    SizedBox(height: isMobile ? 28 : 44),
                    SketchProjectCard(
                      project: project,
                      isMobile: isMobile,
                      displayIndex: 1,
                      isLatest: false,
                      isStackedBehind: false,
                      cardHeight: cardHeight,
                      headerPeekHeight: headerPeekHeight,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        Widget buildStackStage(double localScroll) {
          // Precompute each card's stack progress (Card 0 is always 1.0 at the base)
          final List<double> cardCurves = List<double>.filled(count, 1.0);
          for (int i = 1; i < count; i++) {
            final double rawT =
                ((localScroll - ((i - 1) * scrollPerCard)) /
                        (scrollPerCard * 0.82))
                    .clamp(0.0, 1.0);
            cardCurves[i] = Curves.easeOutCubic.transform(rawT);
          }

          return SizedBox(
            key: _stackTrackKey,
            height: totalTrackHeight,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: localScroll,
                  left: 0,
                  right: 0,
                  height: deckHeight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0; i < count; i++)
                        _buildStackedCardItem(
                          stackIndex: i,
                          totalCount: count,
                          project: orderedProjects[i],
                          originalNumber: i + 1,
                          isMobile: isMobile,
                          cardHeight: cardHeight,
                          headerPeekHeight: headerPeekHeight,
                          deckHeight: deckHeight,
                          scrollPerCard: scrollPerCard,
                          effectiveController: effectiveController,
                          cardCurves: cardCurves,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1480),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPad),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    SketchSectionHeader(
                      tag: '02 // FEATURED WORKS',
                      title: 'Featured Projects',
                      subtitle:
                          'High-performance Flutter mobile apps and web platforms built with clean architecture and smooth user experiences.',
                      isMobile: isMobile,
                      seed: 23,
                    ),
                  SizedBox(height: isMobile ? 32 : 48),
                  if (effectiveController != null && count > 1)
                    AnimatedBuilder(
                      animation: effectiveController,
                      builder: (context, _) {
                        double localScroll = 0.0;
                        if (effectiveController.hasClients) {
                          final RenderObject? renderObj = _stackTrackKey
                              .currentContext
                              ?.findRenderObject();
                          if (renderObj is RenderBox && renderObj.hasSize) {
                            final Offset pos = renderObj.localToGlobal(
                              Offset.zero,
                            );
                            final double pinAnchorY = isMobile ? 84.0 : 112.0;
                            localScroll = (pinAnchorY - pos.dy).clamp(
                              0.0,
                              extraScrollTrack,
                            );
                          }
                        }
                        return buildStackStage(localScroll);
                      },
                    )
                  else
                    buildStackStage(0.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStackedCardItem({
    required int stackIndex,
    required int totalCount,
    required ProjectModel project,
    required int originalNumber,
    required bool isMobile,
    required double cardHeight,
    required double headerPeekHeight,
    required double deckHeight,
    required double scrollPerCard,
    required ScrollController? effectiveController,
    required List<double> cardCurves,
  }) {
    final double progress = cardCurves[stackIndex];

    // How many subsequent cards have slid up on top of this card
    double coveredByCount = 0.0;
    for (int j = stackIndex + 1; j < totalCount; j++) {
      coveredByCount += cardCurves[j];
    }

    final double restingTop = stackIndex * headerPeekHeight;
    final double startTop = deckHeight + 72.0;
    final double currentTop = stackIndex == 0
        ? 0.0
        : (startTop + (restingTop - startTop) * progress);

    final double opacity = stackIndex == 0
        ? 1.0
        : (progress * 2.2).clamp(0.0, 1.0);

    final double stackedScale = (1.0 - (coveredByCount * 0.015)).clamp(
      0.91,
      1.0,
    );

    return Positioned(
      top: currentTop,
      left: 0,
      right: 0,
      height: cardHeight,
      child: IgnorePointer(
        ignoring: opacity < 0.15,
        child: Opacity(
          opacity: opacity,
          child: Transform.scale(
            alignment: Alignment.topCenter,
            scaleX: stackedScale,
            scaleY: 1.0,
            child: RepaintBoundary(
              child: SketchProjectCard(
                project: project,
                isMobile: isMobile,
                displayIndex: originalNumber,
                isLatest: false,
                isStackedBehind: coveredByCount > 0.25,
                stackCoverProgress: coveredByCount.clamp(0.0, 1.0),
                cardHeight: cardHeight,
                headerPeekHeight: headerPeekHeight,
                onHeaderTap: (effectiveController != null && totalCount > 1)
                    ? () {
                        if (!effectiveController.hasClients) return;
                        final RenderObject? renderObj = _stackTrackKey
                            .currentContext
                            ?.findRenderObject();
                        if (renderObj is RenderBox && renderObj.hasSize) {
                          final Offset pos = renderObj.localToGlobal(
                            Offset.zero,
                          );
                          final double pinAnchorY = isMobile ? 84.0 : 112.0;
                          final double baseScrollOffset =
                              effectiveController.offset + pos.dy - pinAnchorY;
                          final double targetLocal =
                              stackIndex * scrollPerCard * 0.85;
                          final double targetOffset =
                              (baseScrollOffset + targetLocal).clamp(
                                0.0,
                                effectiveController.position.maxScrollExtent,
                              );
                          effectiveController.animateTo(
                            targetOffset,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubic,
                          );
                        }
                      }
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
