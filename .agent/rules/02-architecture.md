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
│   │   ├── project_controller.dart
│   │   ├── project_model.dart
│   │   └── widgets/
│   ├── contact/
│   │   ├── contact_section.dart
│   │   ├── contact_controller.dart
│   │   └── widgets/
│   └── app_shell/
│       ├── web_home_page.dart       ← Main scaffold + scroll controller
│       └── navigation_controller.dart
│
├── widgets/                         ← Shared/reusable widgets
│   ├── animations/
│   ├── buttons/
│   ├── cards/
│   ├── inputs/
│   ├── layout/
│   │   ├── section_wrapper.dart     ← Standard section container
│   │   ├── responsive_builder.dart  ← Breakpoint-based builder
│   │   └── max_width_container.dart ← Content max-width constraint
│   ├── nav_bar_widget.dart
│   └── bottom_nav_bar_widget.dart
│
├── models/                          ← Data models
├── routes/                          ← Routing configuration
└── services/                        ← External service integrations
```

---

## Naming Conventions

### Files
```
feature_name_section.dart      ← Section/page widgets
feature_name_controller.dart   ← GetX controllers
feature_name_widget.dart       ← Reusable widgets
app_sizes.dart                 ← Core constants (prefixed with app_)
```

### Classes
```dart
class IntroductionSection extends StatelessWidget {}     // Sections
class IntroductionController extends GetxController {}   // Controllers
class ProjectCardWidget extends StatelessWidget {}       // Widgets
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
