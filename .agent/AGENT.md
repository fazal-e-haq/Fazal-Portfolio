# 🏗️ Fazal-e-Haq Portfolio — Agent Master Configuration

> **Priority Level: CRITICAL — ALL rules in this folder are NON-NEGOTIABLE.**
> Every AI agent working on this project MUST read and obey every file in `.agent/` before writing a single line of code.

---

## 🎯 Project Identity

| Key | Value |
| :--- | :--- |
| **Project** | Fazal-e-Haq — Professional Portfolio Website |
| **Framework** | Flutter Web (Dart 3.12+, Flutter 3.44+) |
| **Theme Aesthetic** | **Pencil Sketch & Hand-Drawn Brutalism** (`#FDF0D5` paper, `Patrick Hand` font, charcoal outlines) |
| **State Mgmt** | GetX (`get: ^4.7.3`) |
| **Scroll Model** | Continuous natural vertical scroll with Spatial HUD progression spine |
| **Target** | Production-grade, unique artisanal portfolio web app |
| **Audience** | Recruiters, clients, fellow developers worldwide |
| **Goal** | World-class first impression in < 3 seconds |

---

## 📁 Agent Folder Structure

```
.agent/
├── AGENT.md                          ← You are here (master config)
├── rules/
│   ├── 00-golden-rules.md            ← Absolute top-priority constraints
│   ├── 01-design-system.md           ← Sketch theme colors, Patrick Hand font, sketch borders
│   ├── 02-architecture.md            ← Feature-first code architecture & GetX patterns
│   ├── 03-performance.md             ← Web performance & optimization
│   ├── 04-responsive.md              ← Responsive breakpoints & adaptive design
│   ├── 05-animation.md               ← Motion design, 3D parallax, & micro-interactions
│   ├── 06-accessibility.md           ← A11y, SEO, and semantic structure
│   ├── 07-code-quality.md            ← Dart/Flutter code standards
│   └── 08-deployment.md              ← Build, deploy, Firebase Hosting rules
├── design/
│   ├── design-philosophy.md          ← Hand-drawn sketchbook brand DNA & 3D tilt
│   ├── component-library.md          ← SketchCard, SketchButton, SketchTextField, SketchProjectCard catalog
│   ├── layout-blueprints.md          ← Section-by-section vertical layout specs
│   └── 3d-vertical-redesign-plan.md  ← Master 3D spatial execution plan
└── checklists/
    ├── pre-commit.md                 ← Before every commit verification
    └── production-readiness.md       ← Final launch checklist
```

---

## ⚡ Loading Order

Agents MUST process files in this exact order:
1. `AGENT.md` (this file)
2. `rules/00-golden-rules.md`
3. `rules/01-design-system.md`
4. `rules/02-architecture.md`
5. All remaining `rules/` files
6. `design/` files
7. `checklists/` as needed

---

## 🚫 Hard Stops

If ANY of these are violated, the agent MUST stop and fix before proceeding:
- ❌ **No dark mode/glassmorphism remnants** — strictly enforce the Pencil Sketch Theme (`#FDF0D5` background, charcoal ink borders, `Patrick Hand` typography)
- ❌ **No magic numbers** — use `AppSizes` constants
- ❌ **No hardcoded colors** — use `AppColors` tokens only
- ❌ **No calling `Get.put()` inside widget `build()` methods**
- ❌ **No unresponsive layouts** — must work seamlessly 320px → 2560px
- ❌ **No janky animations** — 60fps minimum, no layout thrashing
- ❌ **No dead code, unused imports, or `print()` in production code**
