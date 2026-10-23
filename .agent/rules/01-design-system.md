# 🎨 Design System — Pencil Sketch & Hand-Drawn Brutalism

> The design system is the single source of truth for all visual decisions.
> All UI components must reflect the hand-drawn sketch / brutalist paper aesthetic.

---

## 📜 Color Architecture

### Aesthetic Philosophy
The theme captures an **artisanal sketchbook / hand-drawn architectural blueprint**:
- Warm yellowish paper background (`#FDF0D5`) reminiscent of parchment, manila drafting paper, or heavy Moleskine sketchbook stock.
- Soft charcoal and ink outlines (`#DD000000`, 87% black) instead of harsh pitch black or digital neon glows.
- Pure transparent surfaces: Cards, app bars, and dialogs have transparent fills (`Colors.transparent`) outlined by wobbly, overlapping sketch borders.
- Zero drop shadows or artificial digital blurs: Depth is achieved through geometry, offset sketch lines, and 3D parallax.

### Token Map (`AppColors`)
| Token | Hex / Value | Description |
| :--- | :--- | :--- |
| `AppColors.background` | `0xFFFDF0D5` | Warm yellowish sketchbook paper |
| `AppColors.primary` | `0xDD000000` | Charcoal black for primary outlines, icons, and titles |
| `AppColors.secondary` | `0xDD000000` | Secondary charcoal ink accent |
| `AppColors.surface` | `Colors.transparent` | Fully transparent card/container background |
| `AppColors.surfaceInner` | `Colors.transparent` | Fully transparent inner container fill |
| `AppColors.textMain` | `0xDD000000` | Primary charcoal ink text (87% black) |
| `AppColors.textSecondary` | `0xBB000000` | Secondary ink text for descriptions (73% black) |
| `AppColors.textMuted` | `0x99000000` | Subtle drafting notes / muted text (60% black) |

### Color Rules
- ❌ **NEVER** use dark mode backgrounds (`#141518`), neon purples, blues, or glassmorphism blurs.
- ❌ **NEVER** use filled colored cards or elevation drop shadows.
- ❌ **NEVER** use raw `Color(0xFF...)` in widgets — always use `AppColors` tokens.
- ✅ All borders and text must use charcoal ink tokens (`AppColors.textMain`, `AppColors.primary`).

---

## ✍️ Typography: Hand-Crafted Lettering

### Font Family
- **Global Family:** `'Patrick Hand'` (included in `assets/fonts/patrick-hand/PatrickHand-Regular.ttf` and configured in `ThemeData`).
- Conveys the organic, casual, yet deliberate feel of hand-drawn drafting notes and architect annotations.

### Hierarchy & Scale
| Level | Font Size | Weight | Tracking / Notes |
| :--- | :---: | :---: | :--- |
| **Massive Parallax Background** | `width * 0.7` | `w900` | `letterSpacing: 20.0`, 15% opacity charcoal ink |
| **Hero Name** | `64px` (Desktop) / `36px` (Mobile) | `w900` | All-caps, scaled via `FittedBox` |
| **Hero Role / Subtitle** | `32px` (Desktop) / `20px` (Mobile) | `w900` | Animated typewriter or typewriter kit |
| **Section Headings** | `28px - 36px` | `w900` | Accompanying hand-drawn indicator bar (32x3px) |
| **Card / Bento Titles** | `22px - 28px` | `bold` | Clean, high readability |
| **Body Large** | `14px` (Desktop) / `12px` (Mobile) | `w500` | `height: 1.6` for readable line spacing |
| **Body Medium** | `13px` (Desktop) / `12px` (Mobile) | `w500` | Descriptions and bio content |
| **Captions / Badges** | `11px - 12px` | `w600` | Section anchors, HUD labels, chips |

---

## ✏️ The Hand-Drawn Sketch Technique

### 1. `SketchCard` Dual-Border Offset
Rather than standard straight rectangles, cards simulate hand-drawn pen sketches with two layered borders:
- **Layer 1 (Scribble Border)**: Rotated slightly clockwise at `angle: +0.025 rad`, with a lighter border (`0.3` opacity, 1.5px width) and `BorderRadius.circular(20)`.
- **Layer 2 (Main Border)**: Rotated slightly counter-clockwise at `angle: -0.015 rad`, with a crisp charcoal border (`2.0px` width) and `BorderRadius.circular(16)`.
- **Content Straightening**: The child inside Layer 2 is counter-rotated by `angle: +0.015 rad` so that text, icons, and buttons remain upright and easy to read.

### 2. `SpatialBackdropCanvas` Grid
- Renders an architectural drafting grid (80px spacing) across the entire canvas.
- Painted with faint pencil strokes (`0.03` and `0.02` opacity).
- Contains intentional periodic "crooked" secondary lines to mimic hand-ruled paper.

### 3. `SketchButton` Interactive Action
- Dual-border structure matching `SketchCard`.
- Scribble secondary border rotated counter-clockwise (`-0.025 rad`) with `0.3` opacity charcoal line.
- Main border rotated clockwise (`+0.015 rad`) with `2.0px` charcoal border, counter-rotating the label for crisp readability.
- Hover trigger: slight lift (`-0.05` slide offset, `1.05x` scale).
- Tap trigger: press depth (`+0.05` slide offset, `0.95x` scale).
- Outlined with pure charcoal borders, zero colored fill.
- Backward compatibility: `ButtonWidget` is exported as a direct typedef alias of `SketchButton`.

### 4. `SketchTextField` Hand-Drawn Inputs
- Dual-border layout: background scribble border (`-0.020 rad`) and primary input container.
- Reactive GetX state handling (`TextFieldController`) for focus, hover, and validation.
- Focus trigger: border thickens from 2.0px to 3.0px with instant active indicator.
- Fully transparent input field with `Patrick Hand` typography.

### 5. `SketchProjectCard` Showcase Architecture
- Dual-compartment sketch container: Top screenshot showcase with charcoal divider border, bottom metadata column with project tags and repo links.
- Tactile hover elevation: Scales by `1.02x` on hover and elevates the inner `SketchCard` by `-3px`.

---

## 📐 Spacing & Layout Rhythm (8px Grid)

```
xxs   →  4px   (tight icon gaps)
xs    →  8px   (inline chip spacing)
sm    →  12px  (micro element spacing)
md    →  16px  (mobile card padding, stack gaps)
lg    →  24px  (desktop card padding, icon-to-title)
xl    →  32px  (component cluster gaps)
xxl   →  48px  (headline to grid spacing)
section → 80px (vertical breathing room between sections)
```

- Max Content Width: `1200px` (centered via `ConstrainedBox`).
- Responsive Horizontal Padding: `16px` (Mobile), `40px` (Tablet), `80px` (Desktop).
