# 📐 Layout Blueprints — Hand-Drawn Sketch Layout Specs

> Visual blueprints for each vertical section of the portfolio in the Sketch Theme.

---

## 🗺️ Viewport Flow (Natural Vertical Scroll)

```
┌──────────────────────────────────────────────────────────────┐
│                    FLOATING NAVBAR PILL                      │  ← Top Nav (Desktop)
├──────────────────────────────────────────────────────────────┤
│                                                              │
│     1. INTRODUCTION (Hero Space)                             │
│        • 3D Freestanding Portrait with Optical Parallax      │  [HUD SPINE]
│        • "FAZAL E-HAQ" Massive Charcoal Background Text       │   Live %
│        • Greeting, Role, Call-To-Action Buttons              │   Waypoints
│                                                              │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│     2. ABOUT ME (Bento Grid)                                 │
│        • Left: "The Journey" Story Box + Available Status    │
│        • Right: Service Cards & Tech Stack Categories        │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│     3. FEATURED WORKS (Horizontal Carousel)                  │
│        • Title Anchor: "FEATURED WORKS"                      │
│        • Horizontal ListView of Project Sketch Cards         │
│        • Tags, Description, GitHub & Live Links              │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│     4. CONTACT ("Let's Build Something")                     │
│        • Centered Sketch Container                           │
│        • Direct Email, Message Input Fields, Send Action     │
│        • Social Connect Badges (GitHub, LinkedIn, Instagram) │
│                                                              │
├──────────────────────────────────────────────────────────────┤
│                BOTTOM NAV PILL (Mobile Only)                 │
└──────────────────────────────────────────────────────────────┘
```

---

## 📱 Breakpoint Layout Blueprints

### Section 1: Hero / Introduction (Dynamic First Impression + 3D Scroll)
- **Container Sizing**: Expanded width constrained to `maxWidth: 1680px` (Desktop/Ultrawide) for an expansive, editorial designer presentation.
- **Initial Viewport State (Progress = 0.0)**:
  - Very big uncropped preview of portrait centered (up to `820h × 1000w` desktop, `480w × 393h` mobile) respecting the image's natural `1.221` (1386:1135) aspect ratio.
  - Background typography **HELLO** (`['H', 'E', 'L', 'L', 'O']`) scaled massively (up to `440px` desktop, `220px` mobile) in pure `Patrick Hand` with generous spacing (`42px` desktop, `18px` mobile) and `FittedBox` guaranteeing single-line display across all screen widths.
  - Individual per-letter hover animation (lifts up `-18px`, scales `1.08x`, and darkens ink opacity to `0.85` on hover).
  - Left-hand intro content is hidden at scroll 0.
- **Scroll Down Transition (Progress 0.0 → 0.55)**:
  - 100% GetX reactive architecture, zero `setState`.
  - **HELLO Fade-Out**: Background `"HELLO"` text smoothly fades to `0.0` opacity and is removed from the render tree once hidden so it never clashes with the intro content.
  - **3D Perspective Glide**: Portrait image glides to the right column with 3D perspective (`Matrix4` `rotateY` + `rotateX`), while the left intro content unfolds from 3D space with `"I am"` + `"FAZAL-E-HAQ"` and a hand-drawn `SketchDivider`.
  - Expansive Intro Content Width: Left content column receives 58% of the available width (up to `980px` wide, `clamp(500.0, 980.0)`).
- **Resting & Reading Scroll Plateau (Progress 0.55 → 1.0)**:
  - The hero section remains stationary and pinned in the viewport for an extended **400px+ of comfortable scrolling** before receding into 3D space as the About section scrolls into view.

### Section 2: About (Bento Grid)
- **Desktop (>= 800px)**:
  - Split Bento Row (Height 600px):
    - Flex 5: "The Journey" narrative, design philosophy, and "Available for work" beacon.
    - Flex 7: Right column containing tech stack chips, service specialties, and timeline.
- **Mobile (< 800px)**:
  - Vertical stack of `SketchCard`s with 16px horizontal gutters.

### Section 3: Featured Works
- **Container**: Constrained to 1200px width.
- **Carousel**: Horizontal `ListView.builder` (height: 500px desktop, 450px mobile).
- **Cards**: Hand-drawn `SketchProjectCard` containers with screenshots, project logos, feature badges, and GitHub code URLs.

### Section 4: Contact
- **Container**: Max width 800px centered card.
- **Padding**: 56px desktop, 24px mobile.
- **Inputs**: Name, Email, and Message fields formatted with charcoal sketch borders.
