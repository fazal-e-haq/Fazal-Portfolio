# ✏️ Fazal-e-Haq — Flutter Developer & Software Architect

[![Live Portfolio](https://img.shields.io/badge/Live_Portfolio-fazal--portfolio.web.app-2B2D42?style=for-the-badge&logo=google-chrome&logoColor=FDF0D5)](https://fazal-portfolio.web.app/)
[![Flutter](https://img.shields.io/badge/Flutter-3.44+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![GetX](https://img.shields.io/badge/State_Management-GetX-8A2BE2?style=for-the-badge)](https://pub.dev/packages/get)
[![Firebase](https://img.shields.io/badge/Hosting-Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/)
[![Freelancer Profile](https://img.shields.io/badge/Hire_Me-Freelancer.com-29B2FE?style=for-the-badge&logo=freelancer&logoColor=white)](https://www.freelancer.com/u/FazalehaqDev)

> Official personal portfolio of **Fazal-e-Haq** — Professional Flutter Developer, Software Architect, and Freelancer. Built from the ground up using **Flutter Web** with an authentic, handcrafted **Pencil Sketch & Hand-Drawn Brutalism** design aesthetic.

---

## 🎨 Design Philosophy: Hand-Drawn Pencil Sketch & Brutalism

Unlike generic corporate templates with digital glassmorphism and neon gradients, this portfolio is built with an uncompromising **hand-drawn notebook aesthetic**:

- **Warm Sketchbook Paper:** Warm parchment background (`#FDF0D5`) replicating aged sketch paper.
- **Charcoal Ink Outlines:** Raw organic pencil ink outlines (`#DD000000`, `#BB000000`) with double-wobble hand-drawn path borders.
- **Handwritten Typography:** Powered by Google's **Patrick Hand** across all headings, titles, body text, buttons, and input fields.
- **Zero Digital Drop Shadows:** Authentic 2D brutalist depth rendered using layered ink offset strokes rather than fuzzy blur shadows.
- **Authentic Chalkboard Splash Screen:** Pure matte chalk lettering and eraser dust smudges over a deep blackboard slate with horizontal and vertical full-screen divider expansion.
- **Session-Persisted Flow:** Shows the rich chalkboard splash on first visit, then seamlessly skips it on reloads via `sessionStorage`.

---

## 🏗️ Architecture & Core Principles

- **Feature-First Architecture:** Organized into modular, decoupled domains:
  - `lib/features/introduction/` — Hero presentation, profile portrait, and call-to-actions.
  - `lib/features/about/` — Technical background, development philosophy, and core skillset.
  - `lib/features/projects/` — Flagship mobile and web applications with interactive sketch cards.
  - `lib/features/contact/` — Direct inquiry form with real-time field validation and feedback.
  - `lib/core/` — Theme tokens (`AppColors`, `AppTextStyles`), constants, responsive utilities, and analytics service.
  - `lib/widgets/` — Hand-drawn reusable sketch components (`SketchCard`, `SketchButton`, `SketchTextField`, `SketchMilestoneNode`).
- **Unified Vertical Scroll Experience:** Single-page smooth vertical scroll orchestrated by `ScrollCoordinatorController`, coupled with a floating hand-drawn **Spatial HUD milestone spine**.
- **Performance Optimized:** 0 runtime jank, tree-shaken web fonts, WebP asset compression, and instant first-frame paint.
- **Universal Analytics:** Integrated Google Analytics 4 (`G-CPYQRHSMVQ`) and Firebase Analytics tracking all navigation milestones, project link taps, and button clicks.

---

## 📱 Flagship Projects Featured

### 1. [CutCount](https://github.com/fazal-e-haq/CutCount.git)
A high-performance offline mobile app engineered for barbers and service professionals to log daily client cuts, calculate commission splits, and generate earnings reports without requiring internet connectivity.
- **Tech Stack:** Flutter, Dart, Isar Database (Offline-First Local Storage), Custom State Management.
- **Key Highlights:** Instant search, encrypted local database, automated daily ledger balancing.

### 2. [CopyFlutter](https://copy-flutter.web.app)
A developer utility and open-source UI component library for Flutter developers offering plug-and-play hand-crafted widgets, animations, and templates.
- **Tech Stack:** Flutter Web, Dart, GetX, Cloud Hosting.
- **Key Highlights:** Live interactive preview, instant code copying, cross-platform compatibility.

---

## 🛠️ Technology Stack

| Layer | Technologies & Tools |
| :--- | :--- |
| **Framework** | Flutter Web (Stable channel, CanvasKit / HTML / Wasm ready) |
| **Language** | Dart 3.12+ (Sound null-safety, strict typing) |
| **State Management** | GetX (`^4.7.3`) with reactive controllers |
| **Styling & Assets** | Hand-drawn Custom Painters, Patrick Hand Google Font, WebP Graphics |
| **Hosting & CI/CD** | Firebase Hosting, GitHub Actions automated deployment on merge |
| **Analytics & SEO** | Google Analytics 4, Firebase Analytics SDK, OpenGraph, JSON-LD Structured Data |

---

## 📁 Project Structure

```text
Fazal-Portfolio/
├── lib/
│   ├── core/
│   │   ├── constants/       # App-wide string constants, URLs, and dimensions
│   │   ├── services/        # Analytics, logging, and external service coordinators
│   │   ├── theme/           # Pencil sketch colors, styles, and custom themes
│   │   └── utils/           # Screen size helpers, device breakpoints, and responsive tools
│   ├── features/
│   │   ├── about/           # About Me section, story, and technical metrics
│   │   ├── contact/         # Contact section, GetX controller, and inquiry forms
│   │   ├── home/            # WebHomePage wrapper, navbars, and floating HUD overlay
│   │   ├── introduction/    # Hero intro, headline, and profile avatar
│   │   └── projects/        # Project showcases, cards, and rating stats
│   ├── widgets/             # Reusable sketch cards, buttons, text fields, and dividers
│   └── main.dart            # Application entry point & controller registrations
├── web/
│   ├── index.html           # Meta tags, SEO JSON-LD schema, and splash orchestration
│   ├── splash.css           # Authentic erased chalkboard stylesheet
│   ├── splash.js            # Chalkboard splash controller and session storage logic
│   └── favicon.png          # Portfolio monogram favicon
├── test/                    # Comprehensive unit and widget test suite (17 tests)
├── firebase.json            # Firebase Hosting configuration & security cache headers
└── pubspec.yaml             # Project dependencies and asset declarations
```

---

## 🚀 Running the Project Locally

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>=3.44.0`)
- [Dart SDK](https://dart.dev/get-dart) (`>=3.12.0`)
- Google Chrome (or any modern Chromium/WebKit browser)

### Step-by-Step Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/fazal-e-haq/Fazal-Portfolio.git
   cd Fazal-Portfolio
   ```

2. **Install project dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify static analysis and code quality:**
   ```bash
   flutter analyze
   ```

4. **Execute automated test suite:**
   ```bash
   flutter test
   ```

5. **Launch in local development server:**
   ```bash
   flutter run -d chrome
   ```

6. **Compile optimized production build:**
   ```bash
   flutter build web --release
   ```

---

## 🧪 Quality & Verification Standards

This repository adheres to strict automated quality benchmarks:
- **Zero Analyzer Warnings:** Clean run across all files with `flutter analyze`.
- **100% Passing Tests:** 17 comprehensive unit and widget tests verifying responsive layouts, contact controller actions, analytics dispatchers, and hand-drawn widget mechanics.
- **Production Build Integrity:** Compiles cleanly to `build/web` with icon tree-shaking and asset minification.

---

## 📬 Contact & Collaboration

I am available for **freelance contracts**, **mobile app development**, and **remote Flutter engineering roles** with guaranteed response times under 24 hours.

- 💼 **Freelancer.com:** [freelancer.com/u/FazalehaqDev](https://www.freelancer.com/u/FazalehaqDev)
- 🐙 **GitHub:** [github.com/fazal-e-haq](https://github.com/fazal-e-haq)
- 🔗 **LinkedIn:** [linkedin.com/in/fazal-e-haq3](https://www.linkedin.com/in/fazal-e-haq3)
- 📸 **Instagram:** [instagram.com/fazalehaq.dev](https://www.instagram.com/fazalehaq.dev/)
- 📧 **Email:** [fazalehaq37405@gmail.com](mailto:fazalehaq37405@gmail.com)
- 📄 **Resume:** [Download Resume PDF](https://fazal-portfolio.web.app/Fazal-Resume.pdf)

---

<div align="center">
  <sub>Handcrafted with ✏️ and Flutter by <strong>Fazal-e-Haq</strong></sub>
</div>
