# ✨ Animation & Motion Design — Priority Level: HIGH

> Motion is the soul of the portfolio. It separates "nice website" from "wow, hire this person."
> Every animation must be intentional, performant, and delightful.

---

## Animation Philosophy

### The 4 Purposes of Motion
1. **Guide** → Direct user attention to what matters
2. **Feedback** → Confirm interactions and state changes
3. **Continuity** → Smooth transitions between states
4. **Delight** → Subtle moments that make users smile

If an animation doesn't serve at least one → **remove it**.

---

## Duration Tokens

```dart
abstract class AppDurations {
  /// Micro-interactions (button press, toggle, icon change)
  static const Duration instant = Duration(milliseconds: 100);
  
  /// Small transitions (hover effects, color changes)
  static const Duration fast = Duration(milliseconds: 200);
  
  /// Standard transitions (card reveals, menu open)
  static const Duration normal = Duration(milliseconds: 350);
  
  /// Emphasis animations (section reveals, hero entrance)
  static const Duration slow = Duration(milliseconds: 500);
  
  /// Dramatic animations (page transitions, hero sequences)
  static const Duration dramatic = Duration(milliseconds: 800);
  
  /// Stagger delay between sequential items
  static const Duration staggerDelay = Duration(milliseconds: 80);
  
  /// Long ambient animations (floating elements, gradients)
  static const Duration ambient = Duration(milliseconds: 3000);
}
```

---

## Curve Tokens

```dart
abstract class AppCurves {
  /// Standard ease — most interactions
  static const Curve standard = Curves.easeOutCubic;
  
  /// Entrance — elements appearing
  static const Curve enter = Curves.easeOutBack;
  
  /// Exit — elements disappearing
  static const Curve exit = Curves.easeInCubic;
  
  /// Emphasis — drawing attention
  static const Curve emphasis = Curves.elasticOut;
  
  /// Smooth — ambient/floating animations
  static const Curve smooth = Curves.easeInOutSine;
  
  /// Sharp — snappy interactions
  static const Curve sharp = Curves.easeOutQuart;
}
```

---

## Animation Patterns

### 1. Scroll-Triggered Reveal (Section Entrance)
```
Trigger: Element enters viewport (20% visible)
Animation: Fade in + Slide up (30px → 0px)
Duration: AppDurations.slow
Curve: AppCurves.standard
Stagger: 80ms between children
Fire: Once only (don't re-animate on scroll back)
```

### 2. Staggered List Reveal
```
Trigger: Parent becomes visible
Animation: Each child fades in + slides up sequentially
Duration: AppDurations.normal per item
Stagger: AppDurations.staggerDelay between items
Curve: AppCurves.enter
Max items animated: 8 (rest appear instantly)
```

### 3. Hover Effects (Desktop Only)
```
Card hover:
  - Scale: 1.0 → 1.02 (subtle lift)
  - Border: opacity 0.1 → 0.25
  - Shadow: subtle glow with accent color
  - Duration: AppDurations.fast
  - Curve: AppCurves.standard

Button hover:
  - Background: shift to accent
  - Scale: 1.0 → 1.05
  - Duration: AppDurations.fast

Link hover:
  - Underline: slides in from left
  - Color: shifts to accent
  - Duration: AppDurations.fast
```

### 4. Hero Section Entrance Sequence
```
Step 1 (0ms):     Background gradient fades in
Step 2 (200ms):   Greeting text fades in + slides down
Step 3 (400ms):   Name/title types in or scrambles
Step 4 (600ms):   Subtitle fades in + slides up
Step 5 (800ms):   CTA buttons fade in + scale up
Step 6 (1000ms):  Decorative elements float in
Total: ~1.5 seconds for full hero reveal
```

### 5. Navigation Scroll Effects
```
On scroll down:
  - Nav bar: shrinks height, adds backdrop blur
  - Duration: AppDurations.fast
  - Active section indicator slides smoothly

On scroll to section:
  - Smooth scroll with AppDurations.dramatic
  - Curve: AppCurves.smooth
```

### 6. Ambient/Background Animations
```
Floating decorative elements:
  - Subtle up/down float: ±10px
  - Duration: AppDurations.ambient
  - Curve: AppCurves.smooth
  - Repeat: forever (with reverse)

Gradient shifts:
  - Slow color rotation or position shift
  - Duration: 5-10 seconds per cycle
  - Must be GPU-composited (Transform/Opacity only)
```

---

## Performance Rules for Animation

### DO ✅
- Use `Transform.translate()` / `Transform.scale()` (GPU composited)
- Use `Opacity` widget or `FadeTransition` (GPU composited)
- Wrap animated subtrees in `RepaintBoundary`
- Use `AnimatedBuilder` (not `setState` in animation callbacks)
- Dispose ALL `AnimationController` instances in `onClose()`
- Use `vsync: this` with `GetTickerProviderStateMixin`

### DON'T ❌
- Animate `width`, `height`, `padding`, `margin` (causes layout)
- Use `Timer` or `Future.delayed` for animation loops
- Run more than 3 simultaneous complex animations
- Animate text size (causes text layout recalculation)
- Use `setState()` in animation tick callbacks
- Create animations that can't be interrupted/cancelled

---

## Reduced Motion Support

```dart
// Always check user preference
final reduceMotion = MediaQuery.of(context).disableAnimations;

// If reduced motion:
// - Skip entrance animations (show content immediately)
// - Disable ambient animations
// - Keep essential feedback animations (button press)
// - Use instant durations for transitions
```

---

## Interaction Animations

### Button Press
```
On press down:
  - Scale: 1.0 → 0.96
  - Duration: AppDurations.instant
  - Curve: AppCurves.sharp

On release:
  - Scale: 0.96 → 1.0
  - Duration: AppDurations.fast
  - Curve: AppCurves.enter
```

### Page/Section Transition
```
Out: Fade out + slight scale down (0.98)
In: Fade in + slight scale up (1.0)
Duration: AppDurations.normal
Curve: AppCurves.standard
```
