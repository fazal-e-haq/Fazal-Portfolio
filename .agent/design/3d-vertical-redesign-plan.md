# 🛸 3D Spatial Vertical Redesign — Master Execution Plan

> **Branch:** `redesign`  
> **Status:** Architecture Initialized & Ready for User Sketch  
> **Target:** Award-Winning 3D Spatial Experience + Buttery Smooth 2D Vertical Scroll

---

## 🏛️ Layer Architecture Stack

```
┌─────────────────────────────────────────────────────────────┐
│ 2D LAYER (Top): Floating Modern HUD                         │
│ • Floating top navigation pill (Intro, About, Works, Contact)│
│ • Right-side spatial progress spine (scroll %, dot waypoints)│
│ • Audio / theme toggles (optional)                          │
├─────────────────────────────────────────────────────────────┤
│ HYBRID PERSPECTIVE LAYER (Middle): Section Cards & Content   │
│ • Single continuous vertical scroll (SmoothScrollBehavior)  │
│ • PerspectiveCardWrapper (Matrix4 perspective & 3D tilt)    │
│ • Content reveals linked to camera depth milestones         │
├─────────────────────────────────────────────────────────────┤
│ 3D SPATIAL LAYER (Bottom): World Engine & Camera            │
│ • Scene3DController (Camera X, Y, Z, Yaw, Pitch, Roll)      │
│ • SpatialBackdropCanvas (CustomPainter with 3D projection)  │
│ • Floating particle constellation & depth grid lines        │
│ • Velocity warp on fast scrolling                           │
└─────────────────────────────────────────────────────────────┘
```

---

## 🗺️ 3D Camera Journey by Section

| Milestone | Section | Camera Depth (Z) | Camera Behavior & Spatial Feel |
|---|---|---|---|
| **0.0 - 0.5** | **Intro** | `Z = 0` | Ground zero. 3D tilt portrait, floating magnetic CTA, greeting constellation. |
| **0.5 - 1.5** | **About** | `Z = 400` | Camera travels forward into the galaxy. 3D floating service cards and orbiting tech stack chips. |
| **1.5 - 2.5** | **Works** | `Z = 800` | Perspective shifts to deep showcase dock. 3D app showcase with layered screenshot gallery. |
| **2.5 - 3.0** | **Contact** | `Z = 1200` | Settle in destination terminal. Sunken neumorphic message center, glowing social beacons. |

---

## 📂 Project Folder Structure (3D Redesign Ready)

```
lib/
├── features/
│   ├── app_shell/
│   │   ├── web_home_page.dart                 ← Main scaffold
│   │   ├── navigation_controller.dart         ← Route/index state
│   │   └── scroll_coordinator_controller.dart ← [NEW] Single vertical scroll coordinator
│   ├── scene_3d/
│   │   ├── scene_3d_controller.dart           ← [NEW] Camera matrix & 3D math
│   │   ├── models/
│   │   │   └── scene_point_3d.dart            ← [NEW] 3D vector & perspective projection
│   │   └── widgets/
│   │       ├── spatial_backdrop_canvas.dart   ← [NEW] 3D projection canvas painter
│   │       └── perspective_card_wrapper.dart  ← [NEW] 3D matrix card transform
│   ├── introduction/                          ← Section 1
│   ├── about/                                 ← Section 2
│   ├── project/                               ← Section 3
│   └── contact/                               ← Section 4
└── widgets/
    └── hud/
        └── spatial_hud_overlay.dart           ← [NEW] Vertical progress spine HUD
```

---

## 🚀 Execution Phases

### Phase 1: Foundation Setup (✅ Complete)
- [x] Switched to new branch: `redesign`
- [x] Added `ScrollCoordinatorController` for continuous vertical scrolling
- [x] Added `Scene3DController` and `ScenePoint3D` perspective engine
- [x] Added `SpatialBackdropCanvas` and `PerspectiveCardWrapper`
- [x] Added `SpatialHudOverlay` navigation spine
- [x] Upgraded `web/index.html` with `SiteNavigationElement` schema for Google Sitelinks
- [x] Updated `web/sitemap.xml` timestamps

### Phase 2: Sketch & Feature Intake (⏳ Awaiting User)
- [ ] Receive user's pen/pencil hand-drawn sketch(es)
- [ ] Breakdown specific elements (layout, card arrangements, floating 3D props)
- [ ] Finalize custom design tokens and color harmonies for the new view

### Phase 3: Continuous Scroll Experience
- [ ] Connect sections into a single smooth vertical viewport
- [ ] Synchronize section visibility with scroll percentage (0% → 100%)
- [ ] Bind URL hash anchors (`#intro`, `#about`, `#works`, `#contact`) to scroll positions

### Phase 4: 3D Scene Enrichment
- [ ] Add 3D geometric grid lines or spatial particle tunnels
- [ ] Add velocity-based motion blur or camera tilt on fast scrolling
- [ ] Mobile touch optimization (lightweight projection, disable heavy 3D math on low-power mobile)

### Phase 5: Verification & Launch
- [ ] 60fps/120fps verification across Chrome, Safari, Firefox
- [ ] Test all breakpoints: Mobile (375px), Tablet (768px), Desktop (1440px), Ultrawide (2560px)
- [ ] Verify SEO indexing in Google Search Console
