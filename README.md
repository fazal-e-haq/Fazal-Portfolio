# ✏️ Fazal-e-Haq — Portfolio Architecture & Engineering

[![Live Portfolio](https://img.shields.io/badge/Live_Portfolio-fazal--portfolio.web.app-2B2D42?style=for-the-badge&logo=google-chrome&logoColor=FDF0D5)](https://fazal-portfolio.web.app/)
[![Flutter](https://img.shields.io/badge/Flutter-3.44+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Feature--First_%7C_GetX-8A2BE2?style=for-the-badge)](https://pub.dev/packages/get)
[![Graphics Engine](https://img.shields.io/badge/Graphics-Procedural_CanvasKit-FF5722?style=for-the-badge)](https://flutter.dev/wasm)
[![Hosting](https://img.shields.io/badge/Hosting-Firebase_Edge_CDN-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/)
[![Code Quality](https://img.shields.io/badge/Analyzer-0_Issues_Found-4CAF50?style=for-the-badge&logo=checkmarx&logoColor=white)](https://flutter.dev)

> Deep technical architecture, custom procedural rendering engine, and reactive systems powering the personal portfolio of **Fazal-e-Haq** — Professional Flutter Developer and Software Architect.

---

## 👨‍💻 About Fazal-e-Haq

I am a **Flutter Developer** and **Software Architect** with 3+ years of specialized experience in building high-performance, fault-tolerant mobile and web applications. My engineering philosophy is anchored in three core tenets:

1. **Architectural Rigor:** Clean domain separation, reactive state boundaries, and deterministic data flow across mobile and web platforms.
2. **Sub-Pixel Digital Craftsmanship:** Rejection of generic digital templates; treating user interfaces as bespoke interactive software where every outline, curve, and animation is mathematically and stylistically intentional.
3. **Production-Grade Reliability:** 100% sound null-safety, strict static analysis enforcement (0 warnings), automated regression testing, and instant sub-second boot times.

---

## 🏛️ High-Level System Architecture

This portfolio is built as an advanced, single-page **CanvasKit / Wasm-ready Flutter Web** application with an autonomous pre-boot orchestration layer:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          1. PRE-BOOT RUNTIME LAYER                          │
│                                                                             │
│  [ Session Storage Guard ] ──► [ Erased Blackboard Canvas Engine ]          │
│  Checks `splashShown` key        - Multi-pass chalk dust radial smudges     │
│  Instant zero-flash reload       - Pure matte chalk typography (0 shadow)   │
│                                  - Full-Screen (H+V) divider portal         │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │
                                       ▼ Dispatches 'flutter-first-frame'
┌─────────────────────────────────────────────────────────────────────────────┐
│                       2. FLUTTER WEB CORE APPLICATION                       │
│                                                                             │
│  ┌───────────────────────┐  ┌────────────────────────────────────────────┐  │
│  │ GetX Dependency State │  │ Spatial Coordinate Coordinator             │  │
│  │ - NavController       │  │ - ScrollCoordinatorController              │  │
│  │ - ContactController   │  │ - Floating Spatial HUD Milestone Spine     │  │
│  │ - AnalyticsService    │  │ - Viewport-Aware Section Interpolator      │  │
│  └───────────────────────┘  └────────────────────────────────────────────┘  │
│                                      │                                      │
│                                      ▼                                      │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │ Procedural Hand-Drawn Graphics Engine (Skia / CanvasKit)              │  │
│  │ - SketchPainter: Procedural bezier tremor & double-wobble math        │  │
│  │ - SketchCard / SketchButton / SketchTextField components              │  │
│  │ - Zero raster drop-shadow overhead (100% 60 FPS vector pipeline)     │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────┬──────────────────────────────────────┘
                                       │
                                       ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                   3. TELEMETRY, SEO & INFRASTRUCTURE                        │
│                                                                             │
│  [ Dual-Tier Telemetry ]   [ Semantic SEO Fallback ]  [ Firebase Edge CDN ] │
│  - GA4 (G-CPYQRHSMVQ)      - Crawlable #seo-content   - Strict Imm. Cache   │
│  - Firebase Analytics      - 5x JSON-LD Schemas       - Cache-Bust Overrides│
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔬 How This Portfolio is Built: Technologies Under the Hood

### 1. Procedural Hand-Drawn Vector Engine (`CustomPainter`)
Unlike typical brutalist websites that use static SVG files or heavy raster image textures, this portfolio renders every sketch border dynamically on the GPU using Flutter's `CustomPainter` API:

- **Mathematical Wobble Algorithm (`SketchPainter`):** Every card, button, chip, and input outline generates organic, double-stroked boundaries. Control points on cubic Bezier segments are subjected to calculated pseudo-random offsets:
  $$\Delta x = \sin(\theta \cdot k) \cdot \text{jitterSeed}, \quad \Delta y = \cos(\theta \cdot k) \cdot \text{jitterSeed}$$
  This mimics the natural tremor and dual-pencil graphite pressure of an artist drafting on paper.
- **Warm Parchment & Charcoal Ink Tokens:**
  - Base Paper: `#FDF0D5` (Warm sketchbook parchment).
  - Outlines: `#DD000000` (Primary charcoal ink) and `#BB000000` (Secondary graphite stroke).
  - Accent Color: `#C1121F` (Muted red pencil notation).
- **Zero Digital Drop Shadows:** Traditional CSS/Flutter blur shadows incur severe compositing overhead and break the hand-drawn illusion. Depth is instead achieved purely through offset solid ink boundary strokes, ensuring steady **60 FPS** scroll performance across low-end mobile devices and 4K displays alike.

---

### 2. Spatial HUD & Continuous Vertical Scroll Engine
Rather than relying on browser-native URL page jumps or heavy full-page re-renders:
- **`ScrollCoordinatorController`:** A centralized reactive coordinator that continuously monitors the user's primary scroll offset.
- **Floating Spatial HUD Milestone Spine (`SpatialHudOverlay`):** A custom hand-drawn navigation spine fixed on the viewport. It translates global pixel scroll offsets into discrete spatial milestones (`#intro`, `#about`, `#works`, `#contact`), dynamically animating active milestone nodes and connecting graphite ink paths as the user navigates.
- **Micro-Interaction Feedback:** Smooth scroll animations with mathematical easing curves (`Curves.easeInOutCubic`) ensure seamless navigation between milestones when triggered via keyboard, mouse wheel, or touch gestures.

---

### 3. Authentic Chalkboard Splash & Zero-Flash Session Engine
The pre-boot splash screen was designed to create an immersive, tactile entry experience while preventing duplicate plays on page reload:

- **Erased Blackboard Slate (`#121413`):** Crafted with multi-layered radial gradients simulating cloudy eraser dust, duster streaks, and ghost chalk remnants left on a real blackboard.
- **Pure Matte Chalk Typography:** The headline (`I BUILD DIGITAL PRODUCTS`) and subtitle (`THAT SOLVE REAL PROBLEMS`) use pure `#FDF0D5` chalk pigment with zero digital drop shadows or neon glow halos (`text-shadow: none !important; box-shadow: none !important;`).
- **Bidirectional Screen-Flooding Divider:** The central hand-drawn divider expands both horizontally (`100vw`) and vertically (`110vh`), smoothly morphing the entire viewport into the warm `#FDF0D5` sketchbook paper before disappearing.
- **Session-Persisted Guard (`sessionStorage`):**
  1. An inline `<script>` at the very top of `<head>` checks `sessionStorage.getItem('splashShown')`.
  2. If already shown, it immediately adds `.splash-already-shown` to `<html>`, causing `html.splash-already-shown #splash-container { display: none !important; }` to suppress the splash before the browser paints a single pixel.
  3. This completely eliminates the 1-frame splash flash on page reload. *(Testing override: append `?splash=true` to force replay).*
- **Edge Cache-Busting Tokens:**
  - Assets referenced with query parameters: `splash.css?v=chalk-rough-v3` and `splash.js?v=chalk-rough-v3`.
  - Firebase Hosting configured with explicit `Cache-Control: no-cache, no-store, must-revalidate` for `splash*.@(js|css)`, guaranteeing immediate updates for all worldwide visitors.

---

### 4. Reactive State Management & Dependency Inversion
The portfolio enforces clean separation of concerns using **GetX (`^4.7.3`)**:

- **Strict Lifecycle Architecture:** Zero `Get.put()` calls inside widget `build()` methods. All primary controllers (`NavigationController`, `ScrollCoordinatorController`, `ContactController`, `IntroductionController`, `AboutController`, `ProjectController`) are deterministically registered during `main.dart` initialization.
- **Reactive UI Binding:** State changes are consumed via targeted `Obx()` observers or `GetBuilder` listeners without triggering unnecessary root-tree widget rebuilds.
- **Controller-Driven Form Engine (`ContactController`):** Real-time client-side input validation, error state tracking, and asynchronous submission orchestration for the hand-drawn contact interface.

---

### 5. Dual-Tier Telemetry & Analytics Bridge
The application integrates enterprise-grade analytics tracking via a specialized JavaScript-to-Dart interop bridge:

- **Dual Dispatch:** Every event is simultaneously dispatched to **Google Analytics 4** (`G-CPYQRHSMVQ`) and the **Firebase Analytics Modular Web SDK** (`10.12.0`).
- **Universal Event Dispatcher (`window.logPortfolioEvent`):**
  - **Milestone Navigation:** Tracks milestone views (`milestone_intro`, `milestone_about`, `milestone_works`, `milestone_contact`).
  - **Button & CTA Taps:** Tracks engagement across every sketch button, social link, resume download, and contact submit action.
  - **Project Interactions:** Logs external launches to GitHub repositories and live deployments.

---

### 6. Semantic Search Engine Discovery (SEO) & Fallbacks
Because Flutter Web renders onto an HTML5 Canvas / WebAssembly surface which web spiders cannot parse natively:

- **Semantic HTML Fallback Layer (`#seo-content`):** A crawlable semantic HTML tree rendered in `index.html` featuring semantic headers (`<h1>`, `<h2>`), paragraphs, and navigation links. Search crawlers (Googlebot, Bingbot) index the full text content immediately. Once Flutter's CanvasKit engine fires its first frame (`flutter-first-frame`), the SEO container is gracefully dismantled.
- **5x JSON-LD Structured Data Schemas:**
  1. `schema.org/WebSite` — Global site definition.
  2. `schema.org/Person` — Professional developer identity, skillset, and social profiles.
  3. `schema.org/ProfilePage` — Authoritative profile linking.
  4. `schema.org/BreadcrumbList` — Deep-link section discovery.
  5. `schema.org/FAQPage` — Q&A format answering hiring, technology, and background inquiries for AI search engines (ChatGPT, Gemini, Perplexity).

---

## 🛠️ Complete Technical Stack

| Domain | Technology / Specification | Architectural Purpose |
| :--- | :--- | :--- |
| **Framework** | **Flutter Web 3.44+** | High-performance, cross-platform compiled UI runtime |
| **Language** | **Dart 3.12+** | Sound null-safety, strict typing, AOT compilation |
| **Renderer** | **CanvasKit / WebAssembly** | Skia-backed hardware-accelerated 2D canvas pipeline |
| **State Engine** | **GetX (`^4.7.3`)** | Decoupled reactive state management & dependency injection |
| **Typography** | **Patrick Hand** | Hand-drawn organic Google Font with zero raster blur |
| **Vectors** | **CustomPainter API** | Dynamic Bezier curves with jitter algorithms for sketch borders |
| **Pre-Boot** | **Vanilla HTML5/CSS3/JS** | 0ms chalkboard splash screen with `sessionStorage` guard |
| **Telemetry** | **GA4 + Firebase Analytics** | Dual-tier telemetry bridge via `dart:js_interop` |
| **Hosting & CDN** | **Firebase Hosting** | Global edge CDN with customized Cache-Control headers |
| **CI / CD** | **GitHub Actions** | Automated headless compilation and zero-downtime deployment |

---

## 📁 Repository Directory Map

```text
Fazal-Portfolio/
├── lib/
│   ├── core/
│   │   ├── constants/              # String constants, breakpoints, and external URLs
│   │   ├── services/               # Dual-tier analytics bridge & resume downloader
│   │   ├── themes/                 # Hand-drawn theme tokens, AppColors, and styles
│   │   └── utils/                  # Responsive helpers & screen breakpoint utilities
│   ├── features/
│   │   ├── about/                  # About section: technical metrics & experience
│   │   ├── app_shell/              # WebHomePage shell, spatial scroll & nav coordinator
│   │   ├── contact/                # Contact section: form controller & sketch inputs
│   │   ├── introduction/           # Hero section: portrait sketch, typewriter & stats
│   │   └── project/                # Project showcase: cards, chips & ratings
│   ├── widgets/                    # Reusable hand-drawn UI component library:
│   │   ├── button/                 # SketchButton with double-wobble path outlines
│   │   ├── inputs/                 # SketchTextField with pencil scribble borders
│   │   ├── animations/             # Fade-in-up & 3D coordinate transform wrappers
│   │   ├── sketch_card.dart        # Reusable procedural hand-drawn sketch card
│   │   └── sketch_painter.dart     # Procedural Bezier curve jitter engine
│   └── main.dart                   # Application bootstrap & dependency registration
├── web/
│   ├── index.html                  # SEO schemas, font preloads, and session guard
│   ├── splash.css                  # Authentic erased chalkboard stylesheet
│   ├── splash.js                   # Chalkboard animation controller & reload cleanup
│   ├── robots.txt & sitemap.xml    # Search engine crawl directives
│   └── favicon.png                 # Monogram brand favicon
├── test/                           # 17 automated unit and widget test suites
├── firebase.json                   # Firebase Hosting edge cache rules & headers
└── pubspec.yaml                    # Flutter dependencies and asset tree declarations
```

---

## ⚡ Local Setup & Verification

### Prerequisites
- Flutter SDK `^3.44.0` (Stable channel)
- Dart SDK `^3.12.0`
- Google Chrome or Chromium-based browser

### Execution Commands

```bash
# 1. Clone repository
git clone https://github.com/fazal-e-haq/Fazal-Portfolio.git
cd Fazal-Portfolio

# 2. Fetch dependencies
flutter pub get

# 3. Run static code analyzer (Enforces 0 issues)
flutter analyze

# 4. Run automated test suite (All 17 tests)
flutter test

# 5. Launch local development web server
flutter run -d chrome

# 6. Compile production release bundle
flutter build web --release
```

---

## 📬 Connect & Inquiries

Fazal-e-Haq is available for **Flutter application development**, **mobile & web architecture consulting**, and **remote engineering roles**:

- 💼 **Freelancer.com:** [freelancer.com/u/FazalehaqDev](https://www.freelancer.com/u/FazalehaqDev)
- 🐙 **GitHub:** [github.com/fazal-e-haq](https://github.com/fazal-e-haq)
- 🔗 **LinkedIn:** [linkedin.com/in/fazal-e-haq3](https://www.linkedin.com/in/fazal-e-haq3)
- 📸 **Instagram:** [instagram.com/fazalehaq.dev](https://www.instagram.com/fazalehaq.dev/)
- 📧 **Direct Email:** [fazalehaq37405@gmail.com](mailto:fazalehaq37405@gmail.com)
- 📄 **Resume:** [Download Official Resume PDF](https://fazal-portfolio.web.app/Fazal-Resume.pdf)

---

<div align="center">
  <sub>Handcrafted with ✏️ & Flutter by <strong>Fazal-e-Haq</strong> — Software Architect</sub>
</div>
