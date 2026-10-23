# ✅ Pre-Commit Checklist

> Run through this EVERY TIME before committing code.
> If any item fails → fix before committing.

---

## Code Quality
- [ ] `dart analyze` returns zero issues
- [ ] `dart format --set-exit-if-changed .` passes
- [ ] No `print()` statements in production code
- [ ] No commented-out code blocks
- [ ] No TODO/FIXME/HACK comments
- [ ] No unused imports
- [ ] All new public classes/methods have doc comments

## Design System Compliance
- [ ] No hardcoded colors — all from theme tokens
- [ ] No hardcoded sizes — all from `AppSizes`
- [ ] No hardcoded durations — all from `AppDurations`
- [ ] No raw `TextStyle()` — all from `Theme.of(context).textTheme`
- [ ] `const` used wherever possible
- [ ] Trailing commas on all multi-line structures

## Responsiveness
- [ ] Tested at 375px (mobile)
- [ ] Tested at 768px (tablet)
- [ ] Tested at 1440px (desktop)
- [ ] No horizontal overflow at any width
- [ ] Touch targets ≥ 48px on mobile

## Accessibility
- [ ] Interactive elements have `Semantics` labels
- [ ] Focus order makes logical sense
- [ ] Color contrast meets WCAG AA (4.5:1)

## Performance
- [ ] No unnecessary widget rebuilds
- [ ] `RepaintBoundary` on animated widgets
- [ ] Images optimized (WebP, sized appropriately)
- [ ] No expensive operations in `build()` methods

## Architecture
- [ ] File < 300 lines (or justified)
- [ ] Single public widget per file
- [ ] Imports follow ordering convention
- [ ] Controller logic separated from view
