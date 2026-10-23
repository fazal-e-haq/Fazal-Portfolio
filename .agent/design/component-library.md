# 🧱 Component Library — Sketch Theme Widget Catalog

> Reusable building blocks engineered for the Hand-Drawn Sketch / Brutalist Theme.
> Compose sections from these components rather than duplicating layout logic.

---

## 🖼️ Card & Container Components

### 1. `SketchCard` (`lib/widgets/sketch_card.dart`)
**Purpose:** Primary content block giving a hand-drawn pencil outline look.
```
Architecture:
  - Intrinsic layout sizing: Width and height default to null, allowing the card to wrap its child naturally without triggering unconstrained box errors.
  - Layer 1 (Scribble Border): Positioned.fill rotated at +0.025 rad with low-opacity charcoal border (0.3 opacity, 1.5px width).
  - Layer 2 (Main Container): Non-positioned primary container rotated at -0.015 rad with 2.0px charcoal border.
  - Layer 3 (Child Straightening): Child wrapper inside Layer 2 counter-rotated by +0.015 rad so all text, icons, and buttons remain upright.
  - Hover Pop: AnimatedTranslation offsets the card by -3px on hover.
Props:
  - child: Widget (Required content)
  - width: double? (defaults to null — computes intrinsic width)
  - height: double? (defaults to null — computes intrinsic height)
  - padding: EdgeInsetsGeometry (defaults to EdgeInsets.all(24.0))
  - isHovered: bool (offsets box by -3px for a tactile pop)
  - backgroundColor: Color? (defaults to Colors.transparent)
  - borderRadius: double (defaults to 16.0)
  - showScribbleBorder: bool (defaults to true)
```

### 2. `SpatialBackdropCanvas` (`lib/features/scene_3d/widgets/spatial_backdrop_canvas.dart`)
**Purpose:** Full-screen background drafting grid.
```
Architecture:
  - CustomPainter (_SketchGridPainter) drawing 80px architectural grid.
  - Charcoal ink lines rendered at 0.03 and 0.02 opacity.
  - Periodic crooked lines drawn at intervals to replicate hand-ruled paper.
  - Completely non-intrusive, zero performance cost.
```

---

## 🔘 Interactive & Button Components

### 3. `SketchButton` (`lib/widgets/button/sketch_button.dart`)
**Purpose:** Reusable interactive sketch button with hover/press micro-interactions.
```
Architecture:
  - MouseRegion cursor with GetX ButtonController tracking hover and press states.
  - Dual-border structure:
    • Scribble secondary border rotated counter-clockwise (-0.025 rad) with 0.3 opacity line.
    • Main outline container rotated clockwise (+0.015 rad) with 2.0px charcoal border.
    • Child text counter-rotated (-0.015 rad) for crisp horizontal alignment.
  - AnimatedSlide: -0.05 on hover, +0.05 on press.
  - AnimatedScale: 1.05x on hover, 0.95x on press.
  - External link / mailto: auto-detection and url_launcher dispatch.
Props:
  - text: Widget (Button label, styled with Patrick Hand)
  - icon: Icon? (Optional leading icon)
  - onPressed: void Function()? (Callback)
  - url: String? (External link or mailto: handler)
  - backgroundColor: Color? (defaults to Colors.transparent)
  - padding: EdgeInsets? (defaults to responsive padding)
  - id: String? (Unique identifier for hover state)
Compatibility:
  - Exported typedef: `typedef ButtonWidget = SketchButton;` for full backward compatibility.
```

### 4. `NavBarWidget` & `BottomNavBarWidget` (`lib/widgets/`)
**Purpose:** Floating navigation bars with dual-border sketch pill styling.
```
- Desktop (`NavBarWidget`): Floating top toolbar with center-aligned sketch pill and icon buttons.
- Mobile (`BottomNavBarWidget`): Bottom floating pill constrained to thumb reach.
- Integrated with ScrollCoordinatorController to smoothly scroll to section indices.
```

---

## 📝 Input Components

### 5. `SketchTextField` (`lib/widgets/inputs/sketch_text_field.dart`)
**Purpose:** Hand-drawn outlined input fields for forms and message entry.
```
Architecture:
  - Dual-border layout:
    • Background scribble border rotated at -0.020 rad with 1.5px charcoal line.
    • Primary input container with 2.0px charcoal border (expands to 3.0px when focused).
  - GetX TextFieldController manages reactive hover, focus, and error state per field ID.
  - Safe error handling: Validates errorText?.value null safety before rendering error text, preventing GetX Obx exceptions.
  - Typography: Pure Patrick Hand hint text, label text, and error text.
Props:
  - hintText: String (Input placeholder)
  - icon: IconData (Prefix icon)
  - controller: TextEditingController? (Optional form controller)
  - errorText: RxnString? (Optional GetX observable error message)
  - maxLines: int (defaults to 1; supports multiline message boxes)
```

---

## 💼 Project Showcase Components

### 6. `SketchProjectCard` (`lib/features/project/widgets/sketch_project_card.dart`)
**Purpose:** Hand-drawn featured project card with screenshot preview and metadata.
```
Architecture:
  - Built on SketchCard with padding: EdgeInsets.zero.
  - Top visual area: ClipRRect with curved top corners and charcoal divider border displaying project thumbnail or fallback icon.
  - Bottom metadata area:
    • Project title in Patrick Hand bold.
    • Description with 2-line ellipsis constraint.
    • Wrap row of technology chip badges (Flutter, Dart, Isar DB, etc.) in sketch borders.
    • GitHub code repository link button with external launch handler.
  - Micro-interaction: AnimatedScale (1.02x) on hover with pointer cursor.
Props:
  - project: ProjectModel (Data model with title, description, tech stack, image, repo URL)
  - isMobile: bool (Responsive layout switch: 320px width mobile, 400px desktop)
```

---

## 🧭 Navigation & Progression

### 7. `SpatialHudOverlay` (`lib/widgets/hud/spatial_hud_overlay.dart`)
**Purpose:** Right-aligned floating progress spine for desktop viewport.
```
Architecture:
  - Live percentage text ('${(progress * 100).toInt()}%') in Patrick Hand typography.
  - Interactive waypoint indicator dots that expand to 24px pill when active.
  - Hover tooltips for 'INTRO', 'ABOUT', 'WORKS', 'CONTACT'.
  - On tap: calls ScrollCoordinatorController.scrollToSection(index).
```

---

## 🎬 Animation Components

### 8. `FadeInUpWidget` (`lib/widgets/animations/fade_in_up_widget.dart`)
**Purpose:** Production-safe staggered scroll reveal animation.
```
Architecture:
  - Uses managed Timer? _delayTimer canceled inside dispose() to eliminate memory leaks and test framework assertion failures.
  - Crisp 600ms default duration (reduced from legacy 3500ms) with Curves.easeOutCubic.
  - Smooth vertical slide (from +0.1 to 0.0) combined with FadeTransition.
Props:
  - child: Widget (Required content)
  - delay: Duration (defaults to Duration.zero)
  - duration: Duration (defaults to Duration(milliseconds: 600))
```

### 9. `Scroll3DSection` (`lib/widgets/animations/scroll_3d_section.dart`)
**Purpose:** 3D spatial scroll perspective wrapper for portfolio sections (`AboutSection`, `ProjectsSection`, `ContactSection`).
```
Architecture:
  - Listens to the master ScrollController via AnimatedBuilder and computes the section's live viewport position using RenderBox.localToGlobal.
  - Applies 3D perspective (Matrix4 setEntry(3, 2, 0.0011)), X-axis pitch (rotateX), Z-depth scaling, and vertical parallax as sections enter from the bottom and exit at the top.
  - Locks flat (0 rad tilt, 1.0 scale, 1.0 opacity) inside a central reading deadband so content is crisp while reading.
```

### 10. `SketchBorderPainter`, `SketchDivider`, `SketchSectionHeader` (`lib/widgets/sketch_painter.dart`)
**Purpose:** Organic hand-drawn pencil geometry ensuring zero straight digital lines across all cards, buttons, inputs, badges, and dividers.
```
Architecture:
  - SketchBorderPainter: Subdivides rounded rectangle edges into multi-segment quadratic Bezier curves with deterministic sinusoidal wobble and overlapping pencil passes.
  - SketchDivider: Hand-drawn horizontal wobbly double-stroke pencil rule.
  - SketchSectionHeader: Unified section header with wobbly capsule index tag ('01 // ABOUT ME', etc.), title, and sketched underline.
```

