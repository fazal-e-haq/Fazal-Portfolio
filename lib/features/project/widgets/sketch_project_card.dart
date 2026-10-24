import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/theme.dart';
import '../../../services/analytics_service.dart';
import '../../../widgets/button/sketch_button.dart';
import '../../../widgets/sketch_card.dart';
import '../../../widgets/sketch_painter.dart';
import '../project_model.dart';

/// A large-width, Play Store-inspired project showcase card rendered in the
/// Hand-Drawn Pencil Sketch theme.
///
/// Designed for the Sticky Project Stack:
/// - The top [headerPeekHeight] strip contains the project logo, bold title,
///   short description, and rank badge so that when the next project slides up
///   and stacks on top of this card, this card's title strip remains 100%
///   visible ("seenable title") above the covering card.
/// - Uses [AppColors.background] warm paper fill so stacked cards cleanly cover
///   the body of cards beneath them without visual bleed-through.
class SketchProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isMobile;
  final int displayIndex;
  final bool isLatest;
  final bool isStackedBehind;
  final double stackCoverProgress;
  final double? cardHeight;
  final double headerPeekHeight;
  final VoidCallback? onHeaderTap;

  const SketchProjectCard({
    super.key,
    required this.project,
    required this.isMobile,
    this.displayIndex = 1,
    this.isLatest = false,
    this.isStackedBehind = false,
    this.stackCoverProgress = 0.0,
    this.cardHeight,
    this.headerPeekHeight = 74.0,
    this.onHeaderTap,
  });

  @override
  State<SketchProjectCard> createState() => _SketchProjectCardState();
}

class _SketchProjectCardState extends State<SketchProjectCard> {
  bool _isHovered = false;

  Future<void> _openProjectUrl() async {
    final String url = widget.project.liveUrl ?? widget.project.codeUrl ?? '';
    if (url.isNotEmpty) {
      AnalyticsService.logProjectClick(widget.project.title, url);
      final Uri uri = Uri.parse(url);
      try {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
        );
      } catch (e) {
        debugPrint('Could not launch $url: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final int cardSeed =
        (widget.project.title.hashCode.abs() % 70) +
        (widget.displayIndex * 7) +
        5;
    final double effectiveHeight =
        widget.cardHeight ?? (widget.isMobile ? 590.0 : 630.0);
    final double hPad = widget.isMobile ? 18.0 : 34.0;
    final List<String> galleryImages = widget.project.screenshots.isNotEmpty
        ? widget.project.screenshots
        : (widget.project.imagePath.isNotEmpty
              ? [widget.project.imagePath]
              : const <String>[]);

    final double effectiveCover = widget.stackCoverProgress > 0.0
        ? widget.stackCoverProgress
        : (widget.isStackedBehind ? 1.0 : 0.0);
    final double peekOpacity = ((effectiveCover - 0.25) / 0.55).clamp(0.0, 1.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SketchCard(
        width: double.infinity,
        height: effectiveHeight,
        backgroundColor: AppColors.background,
        borderRadius: 24.0,
        padding: EdgeInsets.symmetric(
          horizontal: hPad,
          vertical: widget.isMobile ? 12.0 : 14.0,
        ),
        isHovered: _isHovered && !widget.isStackedBehind,
        seed: cardSeed,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── 1. Full Play Store View (Always stationary, zero layout shift) ──
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPlayStoreBanner(cardSeed),
                  SizedBox(height: widget.isMobile ? 14.0 : 20.0),
                  Expanded(
                    child: _buildScreenshotGallery(galleryImages, cardSeed),
                  ),
                  SizedBox(height: widget.isMobile ? 12.0 : 18.0),
                  _buildAboutAndTagsFooter(cardSeed),
                ],
              ),
            ),

            // ── 2. Stack Title Strip (ONLY visible when stacked behind another project) ──
            if (peekOpacity > 0.0)
              Positioned(
                top: -(widget.isMobile ? 12.0 : 14.0),
                left: -hPad,
                right: -hPad,
                height: widget.headerPeekHeight,
                child: Opacity(
                  opacity: peekOpacity,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: hPad,
                      vertical: widget.isMobile ? 8.0 : 10.0,
                    ),
                    child: _buildStackTitleStrip(cardSeed),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// The top header bar that stays visible when subsequent cards stack over this card.
  Widget _buildStackTitleStrip(int cardSeed) {
    final String badgeLabel = 'Project ${widget.displayIndex}';

    return GestureDetector(
      onTap: widget.onHeaderTap ?? _openProjectUrl,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: widget.headerPeekHeight - (widget.isMobile ? 14.0 : 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Mini App Icon in wobbly pencil frame
                CustomPaint(
                  painter: SketchBorderPainter(
                    color: AppColors.textMain,
                    strokeWidth: 1.6,
                    borderRadius: 10,
                    wobble: 1.3,
                    seed: cardSeed + 3,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: widget.isMobile ? 28 : 34,
                        height: widget.isMobile ? 28 : 34,
                        child: _buildLogoImage(iconSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: widget.isMobile ? 10 : 14),

                // Project Title (Always visible in the stack!)
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.project.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: widget.isMobile ? 20 : 25,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textMain,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      if (!widget.isMobile &&
                          widget.project.shortDescription.isNotEmpty) ...[
                        const SizedBox(width: 12),
                        Text(
                          '—  ${widget.project.shortDescription}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Category Pill (Desktop/Tablet)
                if (!widget.isMobile) ...[
                  CustomPaint(
                    painter: SketchBorderPainter(
                      color: AppColors.textMain.withValues(alpha: 0.65),
                      strokeWidth: 1.4,
                      borderRadius: 12,
                      wobble: 1.3,
                      seed: cardSeed + 11,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Text(
                        widget.project.type,
                        style: const TextStyle(
                          fontFamily: 'Patrick Hand',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textMain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],

                // Rank / Latest Badge
                CustomPaint(
                  painter: SketchBorderPainter(
                    color: widget.isLatest
                        ? AppColors.primary
                        : AppColors.textMain,
                    strokeWidth: 1.6,
                    borderRadius: 12,
                    wobble: 1.4,
                    seed: cardSeed + 17,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.isMobile ? 10 : 14,
                      vertical: 4,
                    ),
                    child: Text(
                      badgeLabel,
                      style: TextStyle(
                        fontFamily: 'Patrick Hand',
                        fontSize: widget.isMobile ? 12 : 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: widget.isLatest
                            ? AppColors.primary
                            : AppColors.textMain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SketchDivider(height: 6, strokeWidth: 1.6, seed: cardSeed + 19),
          ],
        ),
      ),
    );
  }

  /// Play Store App Info row: Large App Icon, Title, Subtitle, Rating/Downloads/Category stats, and Action CTA.
  Widget _buildPlayStoreBanner(int cardSeed) {
    final bool hasRatingNumber = RegExp(
      r'^[0-9.]+$',
    ).hasMatch(widget.project.rating);

    final Widget statsRow = FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPlayStoreStat(
            value: widget.project.rating,
            suffix: hasRatingNumber ? ' ★' : '',
            label: 'Rating',
          ),
          _buildVerticalSketchDivider(cardSeed + 23),
          _buildPlayStoreStat(
            value: widget.project.downloads,
            suffix: '',
            label: 'Downloads',
          ),
          _buildVerticalSketchDivider(cardSeed + 29),
          _buildPlayStoreStat(
            value: widget.project.type,
            suffix: '',
            label: 'Category',
          ),
        ],
      ),
    );

    final bool hasLive = widget.project.liveUrl != null &&
        widget.project.liveUrl!.isNotEmpty;
    final Widget actionButton = ButtonWidget(
      id: 'project_action_${widget.project.id}_${widget.displayIndex}',
      url: widget.project.liveUrl ?? widget.project.codeUrl,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 20 : 28,
        vertical: widget.isMobile ? 10 : 14,
      ),
      icon: Icon(
        hasLive
            ? CupertinoIcons.arrow_up_right_square
            : CupertinoIcons.chevron_left_slash_chevron_right,
        size: 18,
        color: AppColors.textMain,
      ),
      text: Text(
        hasLive ? 'Open Live App' : 'View on GitHub',
        style: TextStyle(
          fontFamily: 'Patrick Hand',
          fontSize: widget.isMobile ? 15 : 17,
          fontWeight: FontWeight.w900,
          color: AppColors.textMain,
          letterSpacing: 0.8,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Large Play Store App Icon framed in hand-drawn squircle
            CustomPaint(
              painter: SketchBorderPainter(
                color: AppColors.textMain,
                strokeWidth: 2.0,
                borderRadius: 20,
                wobble: 1.8,
                seed: cardSeed + 31,
                isHovered: _isHovered,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: widget.isMobile ? 64 : 88,
                    height: widget.isMobile ? 64 : 88,
                    child: _buildLogoImage(iconSize: widget.isMobile ? 32 : 44),
                  ),
                ),
              ),
            ),
            SizedBox(width: widget.isMobile ? 14 : 24),

            // App Title, Subtitle & Play Store Metrics
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.project.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Patrick Hand',
                            fontSize: widget.isMobile ? 24 : 34,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textMain,
                            height: 1.05,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomPaint(
                        painter: SketchBorderPainter(
                          color: widget.isLatest
                              ? AppColors.primary
                              : AppColors.textMain,
                          strokeWidth: 1.5,
                          borderRadius: 12,
                          wobble: 1.3,
                          seed: cardSeed + 17,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.isMobile ? 8 : 12,
                            vertical: widget.isMobile ? 2 : 4,
                          ),
                          child: Text(
                            'Project ${widget.displayIndex}',
                            style: TextStyle(
                              fontFamily: 'Patrick Hand',
                              fontSize: widget.isMobile ? 12 : 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: widget.isLatest
                                  ? AppColors.primary
                                  : AppColors.textMain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.project.shortDescription.isNotEmpty
                        ? widget.project.shortDescription
                        : widget.project.type,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: widget.isMobile ? 14 : 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: widget.isMobile ? 8 : 12),
                  statsRow,
                ],
              ),
            ),

            // Desktop CTA Button on the right side of the Play Store header
            if (!widget.isMobile) ...[const SizedBox(width: 20), actionButton],
          ],
        ),
        if (widget.isMobile) ...[
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: actionButton),
        ],
      ],
    );
  }

  Widget _buildPlayStoreStat({
    required String value,
    required String suffix,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value$suffix',
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: widget.isMobile ? 14 : 17,
            fontWeight: FontWeight.w900,
            color: AppColors.textMain,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: widget.isMobile ? 11 : 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalSketchDivider(int seed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 12.0 : 20.0),
      child: Transform.rotate(
        angle: (seed.isEven ? 1 : -1) * 0.04,
        child: Container(
          width: 1.8,
          height: 26,
          decoration: BoxDecoration(
            color: AppColors.textMain.withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  /// Play Store Horizontal Screenshot Showcase where every screenshot is framed
  /// in a wobbly hand-drawn pencil border.
  Widget _buildScreenshotGallery(List<String> images, int cardSeed) {
    final bool isWeb = widget.project.type.toLowerCase().contains('web');
    final double screenshotAspectRatio = isWeb ? (16 / 9) : (9 / 16);

    if (images.isEmpty) {
      return CustomPaint(
        painter: SketchBorderPainter(
          color: AppColors.textMain,
          strokeWidth: 1.8,
          borderRadius: 16,
          wobble: 1.7,
          seed: cardSeed + 41,
        ),
        child: Center(
          child: Icon(
            isWeb
                ? CupertinoIcons.macwindow
                : CupertinoIcons.device_phone_portrait,
            size: 56,
            color: AppColors.textMain,
          ),
        ),
      );
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: images.length,
      separatorBuilder: (_, _) => SizedBox(width: widget.isMobile ? 14 : 22),
      itemBuilder: (context, idx) {
        return CustomPaint(
          painter: SketchBorderPainter(
            color: AppColors.textMain,
            strokeWidth: 1.9,
            borderRadius: 16,
            wobble: 1.6,
            seed: cardSeed + 43 + (idx * 7),
            isHovered: _isHovered,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: screenshotAspectRatio,
                child: Container(
                  color: AppColors.background,
                  child: Image.asset(
                    images[idx],
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    cacheWidth: isWeb
                        ? (widget.isMobile ? 800 : 1400)
                        : (widget.isMobile ? 480 : 720),
                    filterQuality: FilterQuality.medium,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          if (frame == null)
                            Center(
                              child: CupertinoActivityIndicator(
                                color: AppColors.textMain.withValues(
                                  alpha: 0.35,
                                ),
                                radius: 12,
                              ),
                            ),
                          AnimatedOpacity(
                            opacity: frame == null ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOut,
                            child: child,
                          ),
                        ],
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.background,
                      alignment: Alignment.center,
                      child: Icon(
                        isWeb
                            ? CupertinoIcons.macwindow
                            : CupertinoIcons.device_phone_portrait,
                        size: 42,
                        color: AppColors.textMain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Play Store "About this app" description and tech stack pills.
  Widget _buildAboutAndTagsFooter(int cardSeed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                'About this project',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Patrick Hand',
                  fontSize: widget.isMobile ? 17 : 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textMain,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              CupertinoIcons.arrow_right,
              size: 16,
              color: AppColors.textMain,
            ),
            if (!widget.isMobile && widget.project.tags.isNotEmpty) ...[
              const SizedBox(width: 16),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(widget.project.tags.length, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _buildTagPill(
                            widget.project.tags[i],
                            cardSeed + 61 + (i * 5),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Text(
          widget.project.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: widget.isMobile ? 14 : 16,
            color: AppColors.textSecondary,
            height: 1.45,
          ),
        ),
        if (widget.isMobile && widget.project.tags.isNotEmpty) ...[
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(widget.project.tags.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _buildTagPill(
                    widget.project.tags[i],
                    cardSeed + 61 + (i * 5),
                  ),
                );
              }),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTagPill(String tag, int seed) {
    return CustomPaint(
      painter: SketchBorderPainter(
        color: AppColors.textMain.withValues(alpha: 0.72),
        strokeWidth: 1.4,
        borderRadius: 12,
        wobble: 1.3,
        seed: seed,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widget.isMobile ? 10 : 14,
          vertical: 4,
        ),
        child: Text(
          tag,
          style: TextStyle(
            fontFamily: 'Patrick Hand',
            fontSize: widget.isMobile ? 12 : 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textMain,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoImage({required double iconSize}) {
    final String logoPath = widget.project.logo.isNotEmpty
        ? widget.project.logo
        : widget.project.imagePath;
    final bool isWeb = widget.project.type.toLowerCase().contains('web');
    if (logoPath.isEmpty) {
      return Center(
        child: Icon(
          isWeb ? CupertinoIcons.macwindow : CupertinoIcons.app_badge,
          size: iconSize,
          color: AppColors.textMain,
        ),
      );
    }
    return Image.asset(
      logoPath,
      fit: BoxFit.cover,
      cacheWidth: 160,
      cacheHeight: 160,
      filterQuality: FilterQuality.medium,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return Stack(
          fit: StackFit.expand,
          children: [
            if (frame == null)
              Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.textMain.withValues(alpha: 0.35),
                  radius: 8,
                ),
              ),
            AnimatedOpacity(
              opacity: frame == null ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: child,
            ),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) => Center(
        child: Icon(
          isWeb ? CupertinoIcons.macwindow : CupertinoIcons.app_badge,
          size: iconSize,
          color: AppColors.textMain,
        ),
      ),
    );
  }
}
