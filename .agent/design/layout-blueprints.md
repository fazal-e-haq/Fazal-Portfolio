# 📐 Layout Blueprints — Section-by-Section Specs

> Exact layout specifications for each section at each breakpoint.
> Follow these blueprints precisely during implementation.

---

## Page Flow (Scroll Order)

```
┌─────────────────────────────┐
│       NAVIGATION BAR        │  ← Fixed / Sticky
├─────────────────────────────┤
│                             │
│     1. HERO / INTRO         │  ← 100vh (full viewport)
│                             │
├─────────────────────────────┤
│                             │
│     2. ABOUT                │  ← Auto height
│                             │
├─────────────────────────────┤
│                             │
│     3. PROJECTS             │  ← Auto height
│                             │
├─────────────────────────────┤
│                             │
│     4. CONTACT              │  ← Auto height
│                             │
├─────────────────────────────┤
│         FOOTER              │  ← Minimal footer
└─────────────────────────────┘
```

---

## Section 1: Hero / Introduction

### Desktop (1025px+)
```
┌──────────────────────────────────────────────────────────────┐
│  [Logo/Name]              [About] [Work] [Contact] [Resume]  │  Nav
├──────────────────────────────────────────────────────────────┤
│                                                              │
│         ░░░░ Decorative background elements ░░░░             │
│                                                              │
│      ┌──────────────────────────────────────┐                │
│      │  Hi, I'm                              │                │
│      │  FAZAL-E-HAQ                          │  ← 72px       │
│      │  Flutter Developer & UI/UX Designer   │  ← Animated   │
│      │                                        │                │
│      │  Brief tagline about passion and       │  ← 18px       │
│      │  what makes me different.              │                │
│      │                                        │                │
│      │  [View My Work]  [Download Resume]     │  ← CTAs       │
│      └──────────────────────────────────────┘                │
│                                                              │
│         Scroll indicator (animated chevron)                   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
Height: 100vh
Content alignment: Center-left or center
Max content width: 800px for text block
Background: Gradient mesh + floating geometric elements
```

### Mobile (< 768px)
```
┌───────────────────────┐
│                       │
│                       │
│     Hi, I'm           │
│     FAZAL-            │  ← 40px
│     E-HAQ             │
│                       │
│     Flutter Dev &     │  ← Animated
│     UI/UX Designer    │
│                       │
│     Brief tagline...  │  ← 16px
│                       │
│   [View My Work]      │
│   [Download Resume]   │
│                       │
│      ↓ scroll         │
│                       │
└───────────────────────┘
Padding: 16px horizontal
Full-width buttons (stacked)
Simplified background (less decoration)
```

---

## Section 2: About

### Desktop
```
┌──────────────────────────────────────────────────────────────┐
│                     "ABOUT" (background text)                │
│                                                              │
│  ┌────────────────────────┐  ┌─────────────────────────────┐│
│  │                        │  │  About Me                    ││
│  │    Professional        │  │                              ││
│  │    Photo/Avatar        │  │  Paragraph about who I am,  ││
│  │    (optional)          │  │  what I love building, and   ││
│  │                        │  │  why I do what I do.         ││
│  │                        │  │                              ││
│  │                        │  │  ┌─────────────────────────┐││
│  └────────────────────────┘  │  │  Tech Stack Grid        │││
│                              │  │  [Flutter] [Dart] [...]  │││
│                              │  └─────────────────────────┘││
│                              └─────────────────────────────┘│
│                                                              │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐           │
│  │Service 1│ │Service 2│ │Service 3│ │Service 4│           │
│  │ Card    │ │ Card    │ │ Card    │ │ Card    │           │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘           │
│                                                              │
│  ┌──────────────────────────────────────────────────────────┐│
│  │  Journey Timeline / Experience                            ││
│  │  ●───────●───────●───────●                                ││
│  └──────────────────────────────────────────────────────────┘│
└──────────────────────────────────────────────────────────────┘
Layout: 2-column (40/60 split) for bio, full-width for services
Services: 4-column grid (glass cards)
Timeline: Full-width horizontal
```

### Mobile
```
┌───────────────────────┐
│       About Me        │
│                       │
│  ┌─────────────────┐  │
│  │  Photo/Avatar   │  │
│  └─────────────────┘  │
│                       │
│  Bio paragraph...     │
│                       │
│  ┌─────────────────┐  │
│  │ Tech Stack      │  │
│  │ [Flutter] [Dart]│  │
│  │ [Firebase] ...  │  │
│  └─────────────────┘  │
│                       │
│  ┌─────────────────┐  │
│  │  Service Card 1 │  │
│  └─────────────────┘  │
│  ┌─────────────────┐  │
│  │  Service Card 2 │  │
│  └─────────────────┘  │
│  ...                  │
│                       │
│  Timeline (vertical)  │
└───────────────────────┘
Single column, stacked
Services: 1-column (full-width cards)
Timeline: Vertical
```

---

## Section 3: Projects

### Desktop
```
┌──────────────────────────────────────────────────────────────┐
│                    "WORK" (background text)                  │
│                                                              │
│  Featured Projects                                           │
│                                                              │
│  ┌──────────────────────────────────────────────────────────┐│
│  │  ┌────────────────┐  ┌──────────────────────────────┐   ││
│  │  │                │  │  Project Title                │   ││
│  │  │   Screenshot   │  │  Description text...          │   ││
│  │  │   / Preview    │  │                               │   ││
│  │  │                │  │  [Flutter] [Dart] [Firebase]  │   ││
│  │  │                │  │                               │   ││
│  │  │                │  │  [Live Demo →]  [GitHub →]    │   ││
│  │  └────────────────┘  └──────────────────────────────┘   ││
│  └──────────────────────────────────────────────────────────┘│
│                                                              │
│  ┌──────────────────────────────────────────────────────────┐│
│  │  ┌──────────────────────────────┐  ┌────────────────┐   ││
│  │  │  Project Title               │  │                │   ││
│  │  │  Description text...         │  │   Screenshot   │   ││
│  │  │                              │  │   / Preview    │   ││
│  │  │  [React] [Node] [MongoDB]   │  │                │   ││
│  │  │                              │  │                │   ││
│  │  │  [Live Demo →]  [GitHub →]  │  └────────────────┘   ││
│  │  └──────────────────────────────┘                       ││
│  └──────────────────────────────────────────────────────────┘│
│                                                              │
│  (Alternating left/right layout for visual variety)          │
└──────────────────────────────────────────────────────────────┘
Layout: Alternating 50/50 split
Image: Scale on hover, overlay on hover
Cards: Full-width glass containers
```

### Mobile
```
┌───────────────────────┐
│   Featured Projects   │
│                       │
│  ┌─────────────────┐  │
│  │   Screenshot    │  │
│  │                 │  │
│  ├─────────────────┤  │
│  │  Project Title  │  │
│  │  Description... │  │
│  │  [Tech] [Stack] │  │
│  │  [Demo] [Code]  │  │
│  └─────────────────┘  │
│                       │
│  ┌─────────────────┐  │
│  │   Screenshot    │  │
│  │                 │  │
│  ├─────────────────┤  │
│  │  Project Title  │  │
│  │  Description... │  │
│  └─────────────────┘  │
└───────────────────────┘
Stacked cards, image always on top
Full-width
```

---

## Section 4: Contact

### Desktop
```
┌──────────────────────────────────────────────────────────────┐
│                   "CONTACT" (background text)                │
│                                                              │
│            Let's Build Something Together                     │
│                                                              │
│            I'm currently open to new opportunities.          │
│            Whether you have a project in mind or             │
│            just want to chat, feel free to reach out.        │
│                                                              │
│                    [Say Hello →]                              │
│                    (mailto: link)                             │
│                                                              │
│            ┌───┐  ┌───┐  ┌───┐  ┌───┐                       │
│            │ GH│  │ LI│  │ TW│  │ IG│                       │
│            └───┘  └───┘  └───┘  └───┘                       │
│            Social media icon buttons                         │
│                                                              │
└──────────────────────────────────────────────────────────────┘
Layout: Centered text, max-width 600px
CTA: Large primary button (mailto:)
Social: Row of icon buttons below
```

### Mobile
```
┌───────────────────────┐
│                       │
│  Let's Build          │
│  Something Together   │
│                       │
│  I'm open to new      │
│  opportunities...     │
│                       │
│  [  Say Hello →  ]    │
│                       │
│  [GH] [LI] [TW] [IG] │
│                       │
└───────────────────────┘
Centered, full-width button
```

---

## Footer

```
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│     Designed & Built by Fazal-e-Haq with Flutter 💙          │
│     © 2025 — All rights reserved                             │
│                                                              │
└──────────────────────────────────────────────────────────────┘
Minimal, single line, muted text
Centered, small font
```
