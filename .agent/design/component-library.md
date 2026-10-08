# 🧱 Component Library — Sketch Theme Widget Catalog

> Reusable building blocks engineered for the Hand-Drawn Sketch / Brutalist Theme.
> Compose sections from these components rather than duplicating layout logic.

---

## 🖼️ Card & Container Components

### 1. `SketchCard` (`lib/widgets/sketch_card.dart`)
**Purpose:** Primary content block giving a hand-drawn pencil outline look.
```
Architecture:
  - Stack with two slightly rotated containers:
    1. Outer scribble border: Transform.rotate(angle: 0.025 rad) with low-opacity charcoal border (0.3).
    2. Main outline box: Transform.rotate(angle: -0.015 rad) with 2.0px charcoal border.
    3. Child wrapper: Transform.rotate(angle: 0.015 rad) to keep internal text perfectly straight.
Props:
  - child: Widget (Required content)
  - width: double (defaults to double.infinity)
  - height: double (defaults to double.infinity)
  - padding: EdgeInsetsGeometry (defaults to EdgeInsets.all(24.0))
  - isHovered: bool (offsets box by -3px for a tactile pop)
  - backgroundColor: Color? (defaults to Colors.transparent)
```

### 2. `SpatialBackdropCanvas` (`lib/features/scene_3d/widgets/spatial_backdrop_canvas.dart`)
**Purpose:** Full-screen background drafting grid.
```
Architecture:
  - CustomPainter (_SketchGridPainter) drawing 80px grid.
  - Charcoal ink lines at 0.03 and 0.02 opacity.
  - Periodic crooked lines drawn at intervals to replicate hand-drawn graph paper.
```

---

## 🔘 Interactive & Button Components

### 3. `ButtonWidget` (`lib/widgets/button/button_widget.dart`)
**Purpose:** Reusable interactive sketch button with hover/press micro-interactions.
```
Architecture:
  - MouseRegion cursor with GetX ButtonController tracking hover and press.
  - Stack with offset scribble border.
  - AnimatedSlide (-0.05 on hover, +0.05 on press).
  - AnimatedScale (1.05x on hover, 0.95x on press).
Props:
  - text: Widget (Button label)
  - icon: Icon? (Optional leading icon)
  - onPressed: void Function()? (Callback)
  - url: String? (External link or mailto: handler)
```

### 4. `NavBarWidget` & `BottomNavBarWidget` (`lib/widgets/`)
**Purpose:** Floating navigation bars with dual-border sketch pill styling.
```
- Desktop: Floating top AppBar toolbar with center-aligned sketch pill and icon buttons.
- Mobile: Bottom floating pill constrained to thumb reach.
- Integrated with ScrollCoordinatorController to smoothly scroll to section indices.
```

---

## 🧭 Navigation & Progression

### 5. `SpatialHudOverlay` (`lib/widgets/hud/spatial_hud_overlay.dart`)
**Purpose:** Right-aligned floating progress spine for desktop.
```
Architecture:
  - Live percentage text ('${(progress * 100).toInt()}%') in Patrick Hand typography.
  - Interactive waypoint indicator dots that expand to 24px pill when active.
  - Hover tooltips for 'INTRO', 'ABOUT', 'WORKS', 'CONTACT'.
  - On tap: calls ScrollCoordinatorController.scrollToSection(index).
```

### 6. `_HoverGlassImage` (`lib/features/introduction/introduction_section.dart`)
**Purpose:** Hero interactive freestanding 3D cutout with optical reverse-parallax.
```
Architecture:
  - Matrix4 perspective tilt reacting to mouse position (-1.0 to 1.0).
  - Background text ('FAZAL', 'E-HAQ') moving with inverted offset (-dx * 20, -dy * 20).
  - Freestanding cutout with smooth AnimatedScale (1.03x) on hover.
```

---

## 📝 Input Components

### 7. `NeumorphicTextField` (`lib/widgets/textfield/neumorphic_textfield.dart`)
**Purpose:** Hand-drawn input fields for contact and text entry.
```
Architecture:
  - Outline border with 2px charcoal ink border (expands to 3px on focus).
  - Patrick Hand font hint and label text.
  - Transparent surface background matching paper background.
```
