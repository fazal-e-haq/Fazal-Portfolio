# ⚡ Performance Rules — Priority Level: HIGH

> Speed is not optional. Every millisecond of load time costs impressions and opportunities.

---

## Core Web Vitals Targets

| Metric | Target   | Measurement |
|--------|----------|-------------|
| FCP    | < 1.5s   | First Contentful Paint |
| LCP    | < 2.5s   | Largest Contentful Paint |
| CLS    | < 0.1    | Cumulative Layout Shift |
| FID    | < 100ms  | First Input Delay |
| TTI    | < 3.5s   | Time to Interactive |

---

## Flutter Web Optimization

### Build Configuration
```bash
# Always build with:
flutter build web --release --web-renderer canvaskit --tree-shake-icons --pwa-strategy none
```

### Image Optimization
- Use **WebP** format for all images (30-50% smaller than JPEG/PNG)
- Implement lazy loading for below-the-fold images
- Provide explicit `width` and `height` to prevent CLS
- Use `Image.asset()` with `cacheWidth`/`cacheHeight` for downscaling
- Maximum image dimensions: 1920px width for full-bleed, 800px for cards
- Compress all images to < 200KB (hero images < 500KB)

### Font Loading
```dart
// Ensure fonts are preloaded in index.html
// Use font-display: swap in CSS to prevent FOIT
```
- Only load the font weights you actually use
- Poppins: Regular (400), Medium (500), SemiBold (600)
- Unbounded: Regular (400), SemiBold (600), Bold (700)

### Code Splitting
- Use deferred imports for non-critical features
- Lazy-load heavy widgets (project galleries, contact forms)
```dart
// Deferred loading example
import 'package:fazal_portfolio/features/contact/contact_section.dart' deferred as contact;
```

### Widget Optimization
```dart
// ✅ Use const constructors EVERYWHERE possible
const SizedBox(height: AppSizes.md)
const Padding(padding: EdgeInsets.all(AppSizes.lg))

// ✅ Use RepaintBoundary for animated sections
RepaintBoundary(
  child: AnimatedWidget(),
)

// ✅ Cache complex decorations
static final _cardDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
  // ...
);

// ❌ Never rebuild expensive widgets unnecessarily
// Use GetX Obx() only around the smallest possible widget tree
```

### Scroll Performance
- Use `ListView.builder()` for long lists (never `Column` with many children for scrollable content)
- Add `addAutomaticKeepAlives: false` for off-screen recycling
- Use `CustomScrollView` with `SliverList` for complex scroll layouts
- Throttle scroll listeners (max 60 callbacks/sec)
- Use `ScrollController` judiciously — dispose always

---

## Animation Performance

### Rules
- ALL animations must run at **60fps** (16.67ms per frame)
- Use `AnimationController` + `AnimatedBuilder` — not `setState()`
- Prefer `Transform` and `Opacity` (composited) over layout-affecting properties
- Use `RepaintBoundary` to isolate animated subtrees
- Stagger animations to reduce simultaneous paint operations

### Banned Patterns
```dart
// ❌ NEVER animate layout properties (causes layout thrash)
AnimatedContainer(width: ..., height: ...)  // Only if absolutely necessary

// ❌ NEVER use Timer for animations
Timer.periodic(Duration(milliseconds: 16), (_) => setState(() {}));

// ✅ Use proper animation APIs
AnimationController + CurvedAnimation + AnimatedBuilder
```

---

## Bundle Size

- Monitor total JS bundle size (target: < 2MB gzipped for CanvasKit)
- Remove unused packages from pubspec.yaml regularly
- Use `--tree-shake-icons` to remove unused Material icons
- Avoid importing entire packages for single utilities
- Run `flutter build web --analyze-size` periodically

---

## Caching Strategy

- Set appropriate cache headers for static assets
- Use content hashing in file names for cache busting
- Service worker for offline capability (optional but recommended)
- Cache Google Fonts locally (already bundled in assets/)

---

## Monitoring Checklist

Before any deployment:
- [ ] Run Lighthouse audit (target: 90+ on all categories)
- [ ] Test on throttled connection (3G Slow)
- [ ] Verify no layout shifts during load
- [ ] Check total transfer size < 5MB
- [ ] Verify all images are optimized
- [ ] Test initial load time < 3 seconds
