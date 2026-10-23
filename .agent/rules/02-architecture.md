# 🏛️ Architecture Rules — Priority Level: CRITICAL

> Clean architecture is non-negotiable. Every file has a purpose, every folder has a boundary.

---

## Project Structure (Target)

```
lib/
├── main.dart                        ← App entry point (minimal)
├── core/
│   ├── constants/
│   │   ├── app_sizes.dart           ← All spacing, sizing tokens
│   │   ├── app_durations.dart       ← All animation durations
│   │   ├── app_curves.dart          ← All animation curves
│   │   ├── app_breakpoints.dart     ← Responsive breakpoints
│   │   ├── app_strings.dart         ← All user-facing text
│   │   ├── social_medias_links.dart ← External URLs
│   │   └── projects_details.dart    ← Project data
│   ├── themes/
│   │   ├── app_theme.dart           ← ThemeData builder
│   │   ├── app_colors.dart          ← Color tokens (extension)
│   │   ├── app_text_styles.dart     ← Text style tokens
│   │   └── app_shadows.dart         ← Shadow/elevation tokens
│   ├── extensions/
│   │   ├── context_extensions.dart  ← BuildContext helpers
│   │   ├── widget_extensions.dart   ← Widget extension methods
│   │   └── string_extensions.dart   ← String utilities
│   └── utils/
│       ├── responsive_utils.dart    ← Breakpoint & scaling helpers
│       └── platform_utils.dart      ← Web-specific utilities
│
├── features/                        ← Feature-based module organization
│   ├── introduction/                ← Hero / landing section
│   │   ├── introduction_section.dart
│   │   ├── introduction_controller.dart
│   │   └── widgets/                 ← Section-specific widgets
│   ├── about/
│   │   ├── about_section.dart
│   │   ├── about_controller.dart
│   │   └── widgets/
│   ├── project/
│   │   ├── projects_section.dart
│   │   ├── project_model.dart
│   │   └── widgets/
│   │       └── sketch_project_card.dart     ← Hand-drawn project card
│   ├── contact/
│   │   ├── contact_section.dart
│   │   └── contact_controller.dart
│   ├── scene_3d/
│   │   ├── scene_3d_controller.dart         ← 3D camera & projection matrix
│   │   ├── models/
│   │   │   └── scene_point_3d.dart          ← 3D vector & perspective projection
│   │   └── widgets/
│   │       ├── spatial_backdrop_canvas.dart ← Drafting grid background
│   │       └── perspective_card_wrapper.dart← Matrix4 3D tilt wrapper
│   └── app_shell/
│       ├── web_home_page.dart               ← Main scaffold + smooth scroll
│       ├── scroll_coordinator_controller.dart← Vertical scroll coordinator
│       └── navigation_controller.dart
│
├── widgets/                                 ← Shared/reusable sketch widgets
│   ├── animations/
│   │   └── fade_in_up_widget.dart           ← Timer-safe entrance animation
│   ├── button/
│   │   ├── sketch_button.dart               ← Dual-border sketch button (alias: ButtonWidget)
│   │   └── button_controller.dart
│   ├── inputs/
│   │   ├── sketch_text_field.dart           ← Hand-drawn outlined text input
│   │   └── textfield_controller.dart        ← Reactive focus & hover state
│   ├── hud/
│   │   └── spatial_hud_overlay.dart         ← Right-side progression spine HUD
│   ├── sketch_card.dart                     ← Core dual-border sketch container
│   ├── nav_bar_widget.dart                  ← Top floating sketch pill nav
│   ├── bottom_nav_bar_widget.dart           ← Mobile bottom sketch nav
│   └── responsive_text.dart
│
├── models/                                  ← Data models
├── routes/                                  ← Routing configuration
└── services/                                ← External service integrations
```

---

## Naming Conventions

### Files
```
feature_name_section.dart      ← Section/page widgets
feature_name_controller.dart   ← GetX controllers
sketch_component_name.dart     ← Reusable sketch widgets (prefixed with sketch_)
app_sizes.dart                 ← Core constants (prefixed with app_)
```

### Classes
```dart
class Introduction extends StatelessWidget {}            // Sections
class ContactController extends GetxController {}        // Controllers
class SketchCard extends StatelessWidget {}              // Sketch containers
class SketchButton extends StatelessWidget {}            // Sketch buttons
class SketchTextField extends StatelessWidget {}         // Sketch inputs
class SketchProjectCard extends StatefulWidget {}        // Project showcase
class AppColors {}                                       // Core tokens
class AppSizes {}                                        // Core constants
```

### Variables & Methods
```dart
// ✅ Descriptive, camelCase
final scrollController = ScrollController();
void navigateToSection(int index) {}
double get sectionOpacity => _calculateOpacity();

// ❌ Never
final sc = ScrollController();     // Abbreviations
void nav(int i) {}                 // Cryptic names
```

---

## GetX Rules

### Controllers
```dart
class ExampleController extends GetxController with GetTickerProviderStateMixin {
  // 1. Observable state
  final isVisible = false.obs;
  
  // 2. Non-observable state
  late final AnimationController animController;
  
  // 3. Lifecycle
  @override
  void onInit() {
    super.onInit();
    _initAnimations();
  }
  
  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }
  
  // 4. Public methods
  void toggleVisibility() => isVisible.toggle();
  
  // 5. Private methods
  void _initAnimations() {}
}
```

### Binding Rules
- Use `Get.lazyPut()` for controllers — never `Get.put()` at top level
- Controllers must be scoped to their feature
- No circular controller dependencies
- Controllers handle **logic only** — no `BuildContext` usage inside controllers

---

## Widget Rules

### Composition Over Inheritance
```dart
// ✅ GOOD — Small, focused widgets composed together
class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeroTitle(),
        const HeroSubtitle(),
        const HeroCTA(),
      ],
    );
  }
}

// ❌ BAD — Monolithic widgets with 200+ lines
class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // ... 200 lines of nested widgets ...
    ]);
  }
}
```

### File Size Limits
- **Max 200 lines** per widget file
- **Max 300 lines** per controller file
- If exceeding → extract sub-widgets or helper methods
- Each widget file should contain exactly **one public widget**

### Import Order
```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. Third-party packages
import 'package:get/get.dart';

// 4. Project imports (absolute)
import 'package:fazal_portfolio/core/constants/app_sizes.dart';
```

---

## Separation of Concerns

| Layer        | Responsibility                  | Can Access          |
|--------------|--------------------------------|---------------------|
| **View**     | UI rendering only              | Controller, Theme   |
| **Controller** | Business logic, state mgmt  | Models, Services    |
| **Model**    | Data structures                | Nothing             |
| **Service**  | External APIs, platform calls  | Models              |
| **Theme**    | Visual tokens                  | Nothing             |
| **Constants**| Static values                  | Nothing             |
