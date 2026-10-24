# ♿ Accessibility & SEO — Priority Level: HIGH

> A portfolio that can't be accessed by everyone is a portfolio that fails.
> Good SEO means recruiters can actually find you.

---

## WCAG 2.1 AA Compliance

### Color Contrast
| Element          | Minimum Ratio | Check Tool |
|------------------|---------------|------------|
| Normal text      | 4.5:1         | WebAIM     |
| Large text (24px+)| 3:1          | WebAIM     |
| UI components    | 3:1           | WebAIM     |
| Focus indicators | 3:1           | WebAIM     |

### Rules
- ✅ Every text element must meet contrast requirements against its background
- ✅ Don't rely on color alone to convey information
- ✅ Provide alternative indicators (icons, patterns, text labels)

---

## Keyboard Navigation

### Tab Order
- Navigation links → Hero CTA → Section content → Cards → Footer links
- Tab order must follow visual reading order (top-to-bottom, left-to-right)
- Skip navigation link at the very top (hidden until focused)

### Focus Management
```dart
// ✅ All interactive elements must show focus indicator
FocusableActionDetector(
  mouseCursor: SystemMouseCursors.click,
  onShowFocusHighlight: (focused) => setState(() => _focused = focused),
  child: AnimatedContainer(
    decoration: BoxDecoration(
      border: Border.all(
        color: _focused ? accentColor : Colors.transparent,
        width: 2,
      ),
    ),
    child: content,
  ),
)
```

### Keyboard Shortcuts
- `Tab` / `Shift+Tab`: Navigate between interactive elements
- `Enter` / `Space`: Activate buttons and links
- `Escape`: Close modals/overlays
- Arrow keys: Navigate within component groups

---

## Semantic HTML (Flutter Web)

### Use Semantics Widget
```dart
// ✅ Always provide semantic meaning
Semantics(
  label: 'Navigate to About section',
  button: true,
  child: NavButton(text: 'About'),
)

Semantics(
  header: true,
  label: 'Fazal-e-Haq — Flutter Developer',
  child: HeroTitle(),
)

Semantics(
  image: true,
  label: 'Screenshot of CutCount mobile application',
  child: ProjectImage(),
)
```

### Section Structure
```dart
// Each major section should have semantic landmarks
Semantics(
  label: 'Introduction section',
  container: true,
  child: IntroductionSection(),
)
```

---

## Screen Reader Support

### Rules
- ✅ All images must have meaningful `Semantics(label: ...)`
- ✅ Decorative images must be excluded: `Semantics(excludeSemantics: true)`
- ✅ Icon buttons must have `Semantics(label: 'Description of action')`
- ✅ Links must describe their destination (not "click here")
- ✅ Dynamic content changes must be announced via `SemanticsService.announce()`
- ✅ Form fields must have associated labels

---

## SEO for Flutter Web

### index.html Meta Tags
```html
<meta name="description" content="Fazal-e-Haq — Professional Flutter Developer & Software Architect. Building beautiful, performant cross-platform applications.">
<meta name="keywords" content="Flutter Developer, Software Architect, Mobile App Developer, Web Developer, Fazal-e-Haq, Portfolio">
<meta name="author" content="Fazal-e-Haq">

<!-- Open Graph -->
<meta property="og:title" content="Fazal-e-Haq — Flutter Developer & Software Architect">
<meta property="og:description" content="Professional portfolio showcasing Flutter apps, software architecture, and full-stack development projects.">
<meta property="og:image" content="https://fazalehaq.com/og-image.png">
<meta property="og:url" content="https://fazalehaq.com">
<meta property="og:type" content="website">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Fazal-e-Haq — Flutter Developer">
<meta name="twitter:description" content="Professional portfolio showcasing Flutter apps and software architecture.">
<meta name="twitter:image" content="https://fazalehaq.com/og-image.png">
```

### Structured Data (JSON-LD)
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Person",
  "name": "Fazal-e-Haq",
  "jobTitle": "Flutter Developer & Software Architect",
  "url": "https://fazalehaq.com",
  "sameAs": [
    "https://github.com/fazalehaq",
    "https://linkedin.com/in/fazalehaq"
  ]
}
</script>
```

### Sitemap & Robots
- Maintain `web/sitemap.xml` with all accessible routes
- Maintain `web/robots.txt` allowing search engine crawlers
- Use semantic URL structure

---

## Loading States

### Rules
- ✅ Show skeleton screens or shimmer effects during load (not blank space)
- ✅ Show meaningful progress indicators for async operations
- ✅ Provide fallback content if assets fail to load
- ✅ Never show a completely blank page during load
- ❌ No spinner-only loading states — show content structure
