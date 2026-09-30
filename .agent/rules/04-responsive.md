# 📱 Responsive & Adaptive Design — Priority Level: CRITICAL

> This portfolio must feel **intentionally designed** for every screen size.
> Not "it fits" — it must look like a separate design was made for each breakpoint.

---

## Breakpoint System

```dart
abstract class AppBreakpoints {
  /// Mobile: 320px – 480px (phones portrait)
  static const double mobile = 0;
  
  /// Mobile Landscape: 481px – 767px
  static const double mobileLandscape = 481;
  
  /// Tablet: 768px – 1024px (iPad, small laptops)
  static const double tablet = 768;
  
  /// Desktop: 1025px – 1440px (standard monitors)
  static const double desktop = 1025;
  
  /// Wide: 1441px – 1920px (large monitors)
  static const double wide = 1441;
  
  /// Ultrawide: 1921px+ (ultrawide, 4K monitors)
  static const double ultrawide = 1921;
}
```

---

## Responsive Builder Pattern

```dart
/// Use this pattern for all major layout decisions
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext) mobile;
  final Widget Function(BuildContext)? tablet;
  final Widget Function(BuildContext)? desktop;
  final Widget Function(BuildContext)? wide;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = MediaQuery.of(context).size.width;
        if (width >= AppBreakpoints.wide && wide != null) return wide!(context);
        if (width >= AppBreakpoints.desktop && desktop != null) return desktop!(context);
        if (width >= AppBreakpoints.tablet && tablet != null) return tablet!(context);
        return mobile(context);
      },
    );
  }
}
```

---

## Layout Rules by Breakpoint

### Mobile (320px – 480px)
- **Grid:** Single column, full-width
- **Padding:** 16px horizontal
- **Navigation:** Bottom nav bar OR hamburger menu
- **Typography:** Scaled down 25-30%
- **Cards:** Full-width, stacked vertically
- **Hero:** Text-focused, minimal decoration
- **Interactions:** Touch-optimized (min tap target 48px)

### Tablet (768px – 1024px)
- **Grid:** 2-column where appropriate
- **Padding:** 24px – 32px horizontal
- **Navigation:** Horizontal nav bar (condensed)
- **Typography:** Scaled down 10-15%
- **Cards:** 2-column grid
- **Hero:** Balanced text + visual elements

### Desktop (1025px – 1440px)
- **Grid:** Multi-column, max-width container (1200px)
- **Padding:** 48px – 80px horizontal
- **Navigation:** Full horizontal nav with hover effects
- **Typography:** Full scale
- **Cards:** 3-column grid or dynamic masonry
- **Hero:** Full cinematic layout with animations

### Wide / Ultrawide (1441px+)
- **Grid:** Max-width container (1400px), centered
- **Padding:** 80px – 120px horizontal (or auto margins)
- **Content:** Never stretches beyond max-width
- **Background:** Decorative elements can extend full-width
- **Extra whitespace:** Use for breathing room, not stretching content

---

## Content Max-Width

```dart
/// ALWAYS constrain content width on large screens
class MaxWidthContainer extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  
  const MaxWidthContainer({
    this.maxWidth = 1200,
    required this.child,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
```

### Rules
- ❌ NEVER let text lines exceed ~75 characters (optimal readability)
- ❌ NEVER let content stretch to full viewport on wide screens
- ✅ Max content width: 1200px (hero can go wider)
- ✅ Max text block width: 700px
- ✅ Center content with auto margins on large screens

---

## Responsive Spacing

```dart
/// Spacing scales with viewport
double responsivePadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width >= AppBreakpoints.wide) return 120;
  if (width >= AppBreakpoints.desktop) return 80;
  if (width >= AppBreakpoints.tablet) return 32;
  return 16;
}
```

---

## Touch vs Hover

```dart
// Detect input method and adapt
final isTouch = MediaQuery.of(context).size.width < AppBreakpoints.tablet;

// Mobile: No hover effects, use tap/press animations instead
// Desktop: Rich hover effects, cursor changes, tooltips
```

### Rules
- Mobile: Tap ripple effects, press-and-hold for secondary actions
- Desktop: Hover elevations, cursor changes, tooltip reveals
- Both: Focus indicators for keyboard navigation

---

## Testing Requirements

Every responsive change MUST be verified at these exact widths:
- 320px (iPhone SE)
- 375px (iPhone 12/13/14)
- 428px (iPhone 14 Pro Max)
- 768px (iPad portrait)
- 1024px (iPad landscape)
- 1280px (Small laptop)
- 1440px (Standard desktop)
- 1920px (Full HD)
- 2560px (QHD / Ultrawide)
