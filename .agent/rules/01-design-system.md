# 🎨 Design System — Priority Level: CRITICAL

> The design system is the single source of truth for all visual decisions.
> No widget may deviate from these tokens without explicit justification.

---

## Color Architecture

### Philosophy
Use a **dark-dominant, high-contrast** palette with strategic accent pops. The dark background creates depth and drama; accent colors create focal points and energy.

### Token Structure
```
Primary Background   → Deep rich dark (near-black with subtle warm/cool undertone)
Secondary Background → Slightly elevated surface (card backgrounds, modals)
Tertiary Background  → Subtle differentiator for nested elements
Primary Text         → High-contrast white/near-white (opacity 0.95)
Secondary Text       → Muted text for descriptions (opacity 0.60-0.70)
Accent Primary       → Hero accent color (electric, vivid — used sparingly)
Accent Secondary     → Complementary accent for hover states, links
Gradient Start/End   → For glass-morphism and depth effects
Border/Divider       → Subtle separators (white at 0.08-0.12 opacity)
```

### Rules
- ❌ NEVER use raw `Color(0xFF...)` in widgets — always theme tokens
- ❌ NEVER use more than 2 accent colors in one viewport
- ✅ Use opacity variations of base colors for hierarchy
- ✅ Gradients must be subtle (max 15% opacity difference)
- ✅ All colors must pass WCAG 2.1 AA contrast checks

---

## Typography Scale

### Font Families
- **Display / Headlines:** `Unbounded` — bold, geometric, modern
- **Body / UI:** `Poppins` — clean, readable, professional

### Scale (Desktop)
```
Display Large   → 72px / Unbounded / Weight 700 / Letter-spacing: -2.0
Display Medium  → 56px / Unbounded / Weight 700 / Letter-spacing: -1.5
Headline Large  → 40px / Unbounded / Weight 600 / Letter-spacing: -1.0
Headline Medium → 32px / Poppins   / Weight 600 / Letter-spacing: -0.5
Title Large     → 24px / Poppins   / Weight 600 / Letter-spacing: 0
Title Medium    → 20px / Poppins   / Weight 500 / Letter-spacing: 0.15
Body Large      → 18px / Poppins   / Weight 400 / Letter-spacing: 0.5
Body Medium     → 16px / Poppins   / Weight 400 / Letter-spacing: 0.25
Body Small      → 14px / Poppins   / Weight 400 / Letter-spacing: 0.4
Label Large     → 14px / Poppins   / Weight 500 / Letter-spacing: 1.0 / UPPERCASE
Label Medium    → 12px / Poppins   / Weight 500 / Letter-spacing: 1.5 / UPPERCASE
Caption         → 11px / Poppins   / Weight 400 / Letter-spacing: 0.4
```

### Responsive Scaling
- **Mobile:** Scale all sizes down by ~25-30%
- **Tablet:** Scale down by ~15%
- Use `AutoSizeText` or `ResponsiveText` for fluid scaling within containers
- Line height: 1.5× for body, 1.2× for headings

### Rules
- ❌ NEVER use raw `TextStyle()` with hardcoded sizes — always `Theme.of(context).textTheme`
- ❌ Max 2 font families total (Unbounded + Poppins)
- ✅ Headings always use `Unbounded`
- ✅ Body/UI always uses `Poppins`
- ✅ Use font weight for hierarchy, not font size alone

---

## Spacing System (8px Grid)

### Base Unit: 8px

```
xxxs  →  2px   (micro adjustments only)
xxs   →  4px   (icon padding, tight gaps)
xs    →  8px   (inline element spacing)
sm    →  12px  (related element spacing)
md    →  16px  (standard component padding)
lg    →  24px  (section internal padding)
xl    →  32px  (between component groups)
xxl   →  48px  (between major sections)
xxxl  →  64px  (page-level section gaps)
huge  →  96px  (hero section breathing room)
mega  →  128px (maximum spacing, ultra-wide only)
```

### Rules
- ❌ NEVER use arbitrary pixel values — always `AppSizes.xx`
- ✅ All spacing must be multiples of 4px (preferably 8px)
- ✅ Vertical rhythm must be consistent within each section
- ✅ Horizontal padding scales with viewport: 16px → 24px → 48px → 80px → 120px

---

## Border Radius

```
none   →  0px   (sharp edges for accent elements)
xs     →  4px   (subtle rounding)
sm     →  8px   (buttons, small cards)
md     →  12px  (standard cards)
lg     →  16px  (large cards, modals)
xl     →  20px  (hero elements)
xxl    →  24px  (feature cards)
full   →  999px (pills, avatars)
```

---

## Elevation & Depth

Use **layered depth** instead of drop shadows:
- Layer 0: Background surface
- Layer 1: Cards, tiles (subtle border + background elevation)
- Layer 2: Floating elements, dropdowns (glassmorphism or elevated bg)
- Layer 3: Modals, overlays (backdrop blur + scrim)

### Glassmorphism Recipe
```dart
Container(
  decoration: BoxDecoration(
    color: theme.surface.withOpacity(0.08),
    borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
    border: Border.all(color: theme.onSurface.withOpacity(0.1)),
    // Use BackdropFilter for blur effect
  ),
)
```

---

## Iconography

- Use **outlined/line** icons primarily (not filled)
- Icon size: 20px (inline), 24px (standard), 32px (featured), 48px (hero)
- Icon color follows text color rules (primary/secondary opacity)
- Consider custom SVG icons for brand consistency
