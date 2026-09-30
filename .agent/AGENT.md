# 🏗️ Fazal-e-Haq Portfolio — Agent Master Configuration

> **Priority Level: CRITICAL — ALL rules in this folder are NON-NEGOTIABLE.**
> Every AI agent working on this project MUST read and obey every file in `.agent/` before writing a single line of code.

---

## 🎯 Project Identity

| Key             | Value                                              |
|-----------------|----------------------------------------------------|
| **Project**     | Fazal-e-Haq — Professional Portfolio Website       |
| **Framework**   | Flutter Web (Dart 3.12+, Flutter 3.44+)            |
| **State Mgmt**  | GetX (`get: ^4.7.3`)                               |
| **Target**      | Production-grade, ultra-modern portfolio web app   |
| **Audience**    | Recruiters, clients, fellow developers worldwide   |
| **Goal**        | World-class first impression in < 3 seconds        |

---

## 📁 Agent Folder Structure

```
.agent/
├── AGENT.md                          ← You are here (master config)
├── rules/
│   ├── 00-golden-rules.md            ← Absolute top-priority constraints
│   ├── 01-design-system.md           ← Typography, colors, spacing, grid
│   ├── 02-architecture.md            ← Code architecture & patterns
│   ├── 03-performance.md             ← Web performance & optimization
│   ├── 04-responsive.md              ← Responsive & adaptive design
│   ├── 05-animation.md               ← Motion design & micro-interactions
│   ├── 06-accessibility.md           ← A11y, SEO, semantic structure
│   ├── 07-code-quality.md            ← Dart/Flutter code standards
│   └── 08-deployment.md              ← Build, deploy, CI/CD rules
├── design/
│   ├── design-philosophy.md          ← Visual identity & brand DNA
│   ├── component-library.md          ← Reusable widget catalog
│   └── layout-blueprints.md          ← Section-by-section layout specs
└── checklists/
    ├── pre-commit.md                 ← Before every commit
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
- ❌ No inline styles — everything through the design system
- ❌ No magic numbers — use `AppSizes` constants
- ❌ No hardcoded colors — use theme tokens only
- ❌ No unresponsive layouts — must work 320px → 2560px
- ❌ No janky animations — 60fps minimum, no layout thrash
- ❌ No accessibility violations — WCAG 2.1 AA minimum
- ❌ No dead code or unused imports
- ❌ No `print()` statements in production code
