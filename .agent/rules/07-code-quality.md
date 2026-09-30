# 🧹 Code Quality Standards — Priority Level: HIGH

> Clean code is not a luxury — it's the foundation. Every file must be a joy to read.

---

## Dart Style Guide

### Follow Official Effective Dart
- [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style)
- [Effective Dart: Usage](https://dart.dev/guides/language/effective-dart/usage)
- [Effective Dart: Design](https://dart.dev/guides/language/effective-dart/design)

### Linting
- Use `flutter_lints` package (already configured)
- **Zero warnings, zero info-level issues** in production code
- Run `dart analyze` before every commit — must pass clean

---

## Code Formatting

### Rules
- Run `dart format .` before every commit
- Line length: 80 characters (Dart default)
- Use trailing commas for multi-line parameter lists
- Use trailing commas for multi-line collection literals

```dart
// ✅ Trailing commas for clean formatting
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(AppSizes.md),
    decoration: BoxDecoration(
      color: theme.surface,
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(),
        const SizedBox(height: AppSizes.sm),
        const DescriptionWidget(),
      ],
    ),
  );
}
```

---

## Documentation

### Required Documentation
```dart
/// Section widget displaying the introduction/hero area.
/// 
/// This is the first section visitors see. It contains:
/// - Animated greeting text
/// - Name and title with typewriter effect
/// - Call-to-action buttons
/// - Decorative background elements
class IntroductionSection extends StatelessWidget {
```

### Rules
- ✅ Every public class must have a doc comment (`///`)
- ✅ Every public method with non-obvious behavior must have a doc comment
- ✅ Use `///` (doc comments), not `//` for API documentation
- ❌ Don't document obvious things (`/// Returns the widget` on `build()`)
- ❌ Don't leave TODO comments in production code
- ❌ Don't leave commented-out code blocks

---

## const Usage

```dart
// ✅ Use const EVERYWHERE it's valid
const SizedBox(height: AppSizes.md)
const EdgeInsets.all(16)
const TextStyle(fontWeight: FontWeight.bold)
const Icon(Icons.arrow_forward)

// ✅ Mark constructors as const when possible
class AppSizes {
  const AppSizes._(); // Private const constructor for utility class
}

// ✅ Prefer const widgets — they skip rebuild entirely
const HeroDecorations()  // If no runtime state needed
```

---

## Error Handling

```dart
// ✅ Handle errors gracefully — never crash in production
try {
  await launchUrl(Uri.parse(url));
} catch (e) {
  // Show user-friendly feedback
  Get.snackbar('Oops', 'Could not open the link');
  debugPrint('URL launch failed: $e');
}

// ✅ Use null-safety properly
final String? nullableValue;
final display = nullableValue ?? 'Default';  // Provide fallback

// ❌ Never use ! bang operator without certainty
// ❌ Never swallow errors silently (empty catch blocks)
```

---

## Testing (Minimum Bar)

- Widget tests for each section's rendering
- Controller tests for state management logic
- Golden tests for visual regression (stretch goal)
- Test responsive layouts at key breakpoints

---

## Git Hygiene

### Commit Messages
```
feat: add glassmorphic project card with hover effects
fix: resolve CLS on hero section image load
refactor: extract responsive spacing into utility
style: apply consistent border radius tokens
perf: lazy-load project images below the fold
docs: update README with deployment instructions
```

### Branch Rules
- `main` — production, always deployable
- `ultra-redesign` — current redesign work
- Feature branches from `ultra-redesign` if needed

### Prohibited in Commits
- ❌ `print()` statements
- ❌ Commented-out code
- ❌ TODO/FIXME/HACK comments
- ❌ Debug flags left enabled
- ❌ Unused imports or variables
- ❌ Files > 300 lines without justification
