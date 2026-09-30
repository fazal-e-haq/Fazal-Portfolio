# 🥇 Golden Rules — Priority Level: ABSOLUTE

> These rules override EVERYTHING. No exception. No negotiation. No "just this once."

---

## Rule 1: Design-First, Code-Second

Every UI change must be justified by a design principle. Never write code "just to make it work." Every pixel must earn its place. Ask: **"Does this make the user feel something?"** If no — redesign.

## Rule 2: Production or Nothing

Every single line of code must be production-ready. No TODOs left behind, no commented-out code, no placeholder content. If it's in the codebase, it ships.

## Rule 3: Performance is a Feature

A beautiful site that takes 5 seconds to load is a failed site. Target:
- **First Contentful Paint (FCP):** < 1.5s
- **Largest Contentful Paint (LCP):** < 2.5s
- **Cumulative Layout Shift (CLS):** < 0.1
- **Total bundle size:** Minimize aggressively with tree shaking and deferred loading

## Rule 4: Responsive is Not Optional

The portfolio MUST look intentionally designed at every breakpoint:
- Mobile: 320px – 480px
- Tablet: 481px – 1024px
- Desktop: 1025px – 1440px
- Ultrawide: 1441px – 2560px+

Not "it fits" — it must look **intentionally crafted** for each range.

## Rule 5: Consistency is King

- Same spacing rhythm everywhere
- Same animation curves everywhere
- Same component patterns everywhere
- Same naming conventions everywhere
- Zero one-off hacks

## Rule 6: Accessibility is Human Decency

- All interactive elements must be keyboard navigable
- Contrast ratios must meet WCAG 2.1 AA (4.5:1 for text, 3:1 for large text)
- Screen readers must make sense of the page
- Focus indicators must be visible and styled

## Rule 7: Animation with Purpose

Every animation must serve one of these purposes:
1. **Guide attention** — draw eye to important content
2. **Provide feedback** — confirm user action
3. **Create continuity** — smooth transitions between states
4. **Establish hierarchy** — staggered reveals show content order

If an animation doesn't serve one of these → remove it.

## Rule 8: Code Tells a Story

```dart
// ❌ BAD — What does this mean?
Container(margin: EdgeInsets.only(top: 47))

// ✅ GOOD — Self-documenting
Padding(padding: EdgeInsets.only(top: AppSizes.sectionSpacing))
```

## Rule 9: The 3-Second Rule

A visitor must understand WHO Fazal is, WHAT he does, and WHY they should care — all within 3 seconds of landing on the page. The hero section is the most important real estate on the entire site.

## Rule 10: Zero Tolerance for Mediocrity

If a component, section, or interaction doesn't make you think "damn, that's clean" — it's not done. Push further. Iterate. The bar is the best portfolio sites in the world (Brittany Chiang, Bruno Simon, Adham Dannaway).
