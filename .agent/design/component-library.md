# 🧱 Component Library — Reusable Widget Catalog

> Every widget in this catalog is a building block.
> Compose sections from these — never create one-off widgets that duplicate functionality.

---

## Layout Components

### 1. `SectionWrapper`
**Purpose:** Standard container for every major section.
```
Props:
  - sectionId: String (for scroll targeting)
  - backgroundColor: Color? (defaults to theme surface)
  - maxWidth: double (default 1200)
  - padding: EdgeInsets (responsive)

Behavior:
  - Centers content with max-width constraint
  - Applies responsive horizontal padding
  - Provides semantic landmark for accessibility
  - Optional background color/gradient
```

### 2. `MaxWidthContainer`
**Purpose:** Constrains content width on large screens.
```
Props:
  - maxWidth: double (default 1200)
  - child: Widget

Behavior:
  - Centers content with ConstrainedBox
  - Allows background to extend full-width while content stays centered
```

### 3. `ResponsiveBuilder`
**Purpose:** Renders different layouts per breakpoint.
```
Props:
  - mobile: Widget Function(BuildContext)
  - tablet: Widget Function(BuildContext)?
  - desktop: Widget Function(BuildContext)?
  - wide: Widget Function(BuildContext)?

Behavior:
  - Uses LayoutBuilder + MediaQuery to select appropriate builder
  - Falls back to smaller breakpoint if larger not provided
```

### 4. `SectionBackgroundText`
**Purpose:** Large decorative text behind section content.
```
Props:
  - text: String
  - opacity: double (0.02 - 0.05)

Behavior:
  - Renders massive text (120px+) as visual anchor
  - Positioned absolutely behind section content
  - Does not affect layout or scrolling
  - Hidden on mobile (saves rendering)
```

---

## Typography Components

### 5. `GradientText`
**Purpose:** Text with gradient fill for accent headlines.
```
Props:
  - text: String
  - gradient: Gradient
  - style: TextStyle

Behavior:
  - Applies gradient shader to text
  - Falls back to solid color on reduced capability
```

### 6. `AnimatedTypingText`
**Purpose:** Typewriter effect for hero section.
```
Props:
  - texts: List<String> (cycle through)
  - typingSpeed: Duration
  - pauseDuration: Duration
  - style: TextStyle

Behavior:
  - Types out text character by character
  - Pauses, then deletes and types next text
  - Blinking cursor at end
```

### 7. `ResponsiveText`
**Purpose:** Text that scales smoothly across breakpoints.
```
Props:
  - text: String
  - style: TextStyle
  - minFontSize: double
  - maxLines: int

Behavior:
  - Uses AutoSizeText internally
  - Scales down to minFontSize before wrapping
```

---

## Card Components

### 8. `GlassCard`
**Purpose:** Glassmorphic card for elevated content.
```
Props:
  - child: Widget
  - borderRadius: double
  - blur: double (backdrop blur amount)
  - borderOpacity: double
  - backgroundColor: Color (with opacity)
  - onTap: VoidCallback?
  - onHover: ValueChanged<bool>?

Behavior:
  - Semi-transparent background with backdrop blur
  - Subtle border glow
  - Hover animation: slight scale + border brightness increase
  - Press animation: scale down 0.98
```

### 9. `ProjectCard`
**Purpose:** Showcase card for portfolio projects.
```
Props:
  - project: ProjectModel
  - isReversed: bool (alternating layout)

Behavior:
  - Desktop: Side-by-side (image + details), alternating left/right
  - Mobile: Stacked (image on top)
  - Hover: Image scale, overlay reveal with links
  - Tech stack pills below description
  - Links: Live demo + GitHub source
```

### 10. `SkillChip`
**Purpose:** Technology/skill badge.
```
Props:
  - label: String
  - icon: Widget? (optional tech icon)
  - isHighlighted: bool

Behavior:
  - Pill-shaped with subtle border
  - Hover: background fill with accent
  - Optional leading icon (tech logo)
```

---

## Navigation Components

### 11. `NavBarWidget`
**Purpose:** Desktop navigation bar.
```
Behavior:
  - Fixed top, full-width
  - Transparent initially → glassmorphic on scroll
  - Logo/name on left, nav items on right
  - Active section indicator (animated underline)
  - Smooth scroll to section on click
  - Height shrinks on scroll (64px → 56px)
```

### 12. `BottomNavBarWidget`
**Purpose:** Mobile navigation bar.
```
Behavior:
  - Fixed bottom, full-width
  - Glassmorphic background
  - Icon + label for each section
  - Active indicator (filled icon + accent color)
  - Safe area aware
```

---

## Animation Components

### 13. `FadeInUpWidget`
**Purpose:** Scroll-triggered entrance animation.
```
Props:
  - child: Widget
  - delay: Duration
  - duration: Duration
  - offset: double (slide distance, default 30px)

Behavior:
  - Invisible initially
  - When scrolled into view: fade in + slide up
  - Fires once only (doesn't re-animate)
  - Respects reduced motion preference
```

### 14. `StaggeredList`
**Purpose:** Container that staggers children's entrance.
```
Props:
  - children: List<Widget>
  - staggerDelay: Duration (default 80ms)
  - direction: Axis

Behavior:
  - Each child animates in sequence with stagger delay
  - Wraps each child in FadeInUpWidget with incrementing delay
```

---

## Button Components

### 15. `PrimaryButton`
**Purpose:** Main CTA button.
```
Props:
  - label: String
  - onTap: VoidCallback
  - icon: IconData? (trailing icon)
  - isLoading: bool

Behavior:
  - Filled background with accent color
  - Hover: slight brighten + scale 1.05
  - Press: scale 0.96
  - Loading: replace label with small spinner
  - Focus: visible ring
```

### 16. `SecondaryButton`
**Purpose:** Secondary/outline CTA button.
```
Props:
  - label: String
  - onTap: VoidCallback
  - icon: IconData?

Behavior:
  - Transparent background with accent border
  - Hover: fill with accent at low opacity
  - Same press/focus behavior as PrimaryButton
```

### 17. `IconLinkButton`
**Purpose:** Social media / external link button.
```
Props:
  - icon: Widget (SVG or IconData)
  - url: String
  - tooltip: String

Behavior:
  - Circular or rounded-square container
  - Hover: scale + accent background
  - Opens URL in new tab
  - Tooltip on hover (desktop)
```

---

## Form Components

### 18. `GlassTextField`
**Purpose:** Styled text input for contact form.
```
Props:
  - label: String
  - hint: String
  - controller: TextEditingController
  - maxLines: int
  - validator: String? Function(String?)?

Behavior:
  - Glassmorphic container styling
  - Animated label (float up on focus)
  - Focus: accent border glow
  - Error: red border + error text below
```
