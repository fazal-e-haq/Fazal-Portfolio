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

### Section 1: Hero / Introduction
- **Desktop (>= 800px)**:
  - Width constrained to 1200px.
  - Freestanding portrait sized `700x900px` centered with interactive tilt.
  - Background name typography rendered at `fontSize: width * 0.7`.
  - Action buttons (`ButtonWidget`) for Projects and Resume.
- **Mobile (< 800px)**:
  - Portrait sized `400x520px`.
  - Name rendered at `36px`, role at `20px`.
  - Vertical stacking with touch-friendly tap targets.

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
- **Cards**: Hand-drawn `SketchCard` containers with screenshots, project logos, feature badges, and GitHub code URLs.

### Section 4: Contact
- **Container**: Max width 800px centered card.
- **Padding**: 56px desktop, 24px mobile.
- **Inputs**: Name, Email, and Message fields formatted with charcoal sketch borders.
