# 🏗️ Fazal-e-Haq Portfolio — Gemini Workspace Instructions

> **CRITICAL**: Every AI agent operating on this project MUST adhere strictly to the **Pencil Sketch / Hand-Drawn Brutalism** architecture documented below and in the `.agent/` directory.

---

## 🎯 Project Stack & Identity
- **Developer**: Fazal-e-Haq — Flutter Developer & Software Architect
- **Framework**: Flutter Web (Dart 3.12+, Flutter 3.44+)
- **Architecture**: Feature-first (`features/`, `core/`, `widgets/`) with GetX (`^4.7.3`)
- **Theme**: **Pencil Sketch & Hand-Drawn Brutalism**
  - Background: Warm yellowish sketchbook paper (`#FDF0D5`)
  - Typography: Pure `Patrick Hand` across all headers, copy, buttons, and inputs
  - Outlines: Soft charcoal ink (`#DD000000`, `#BB000000`), zero colored fills, zero digital drop shadows
  - Visual Elements: Double-wobble outlines (`SketchCard`, `SketchButton`, `SketchTextField`, `SketchProjectCard`)
- **Scroll Architecture**: Smooth continuous vertical scroll (`WebHomePage`) with floating Spatial HUD milestone spine (`SpatialHudOverlay`)

---

## ⚡ Non-Negotiable Hard Stops
1. **Pencil Sketch Theme Compliance**: All widgets must inherit the Sketch / Brutalist tokens (`AppColors.background`, `AppColors.primary`, `AppColors.textMain`, `SketchCard`). No dark-mode neon glows, no glassmorphism blurs.
2. **Typography**: Always use `'Patrick Hand'`.
3. **No `Get.put()` in `build()`**: Never instantiate GetX controllers inside widget `build()` methods. All controllers are initialized in `main.dart` or via lifecycle methods.
4. **Responsive Integrity**: All sections must render seamlessly across Mobile (<800px), Tablet, and Desktop (1200px max width).
5. **Code Quality**: Zero `flutter analyze` errors or warnings. No unused imports. No `print()` statements in production code.

---

## 📚 Specialized Agent Documentation
Before executing specific tasks, review the specialized manuals in `.agent/`:
- **UI Design System**: [`.agent/rules/01-design-system.md`](.agent/rules/01-design-system.md)
- **Component Catalog**: [`.agent/design/component-library.md`](.agent/design/component-library.md)
- **Architecture Guidelines**: [`.agent/rules/02-architecture.md`](.agent/rules/02-architecture.md)
- **Performance Budget**: [`.agent/rules/03-performance.md`](.agent/rules/03-performance.md)
- **Pre-Commit Verification**: [`.agent/checklists/pre-commit.md`](.agent/checklists/pre-commit.md)
