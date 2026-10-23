# 🚀 Deployment & Build Rules — Priority Level: HIGH

> If it doesn't deploy cleanly, it doesn't matter how good it looks.

---

## Build Commands

### Development
```bash
flutter run -d chrome --web-renderer canvaskit
```

### Production Build
```bash
flutter build web --release --web-renderer canvaskit --tree-shake-icons --pwa-strategy none
```

### Pre-Build Checks
```bash
# Must ALL pass before building
dart analyze                  # Zero issues
dart format --set-exit-if-changed .  # Formatting clean
flutter test                  # All tests pass
```

---

## Hosting: Firebase Hosting

### Configuration
- Project is configured with Firebase Hosting (`.firebaserc`, `firebase.json`)
- Deploy target: `build/web/`
- Custom domain configured (if applicable)

### Deploy Command
```bash
firebase deploy --only hosting
```

### Pre-Deploy Checklist
- [ ] `flutter build web --release` succeeds
- [ ] `dart analyze` shows zero issues
- [ ] All tests pass
- [ ] Lighthouse score ≥ 90 on Performance, Accessibility, Best Practices, SEO
- [ ] Tested on Chrome, Firefox, Safari, Edge
- [ ] Tested on mobile device (real device, not just emulator)
- [ ] All links work (no 404s)
- [ ] Resume PDF downloads correctly
- [ ] Contact links open correctly
- [ ] Open Graph preview looks correct (use og debugger tools)

---

## Environment

### Required Versions
- Flutter: 3.44+ (latest stable)
- Dart: 3.12+
- Node.js: 18+ (for Firebase CLI)
- Firebase CLI: Latest

### Firebase Configuration Files
```
.firebaserc         → Project alias config
firebase.json       → Hosting config, headers, redirects
web/index.html      → Entry point with meta tags
web/manifest.json   → PWA manifest
web/robots.txt      → Search engine directives
web/sitemap.xml     → Site structure for crawlers
```

---

## Headers & Caching

### firebase.json hosting config should include:
```json
{
  "hosting": {
    "headers": [
      {
        "source": "**/*.@(jpg|jpeg|gif|png|svg|webp|ico)",
        "headers": [
          { "key": "Cache-Control", "value": "max-age=31536000, immutable" }
        ]
      },
      {
        "source": "**/*.@(js|css|wasm)",
        "headers": [
          { "key": "Cache-Control", "value": "max-age=31536000, immutable" }
        ]
      },
      {
        "source": "**/*.@(woff|woff2|ttf|otf)",
        "headers": [
          { "key": "Cache-Control", "value": "max-age=31536000, immutable" }
        ]
      },
      {
        "source": "index.html",
        "headers": [
          { "key": "Cache-Control", "value": "no-cache" }
        ]
      }
    ]
  }
}
```

---

## Security Headers

```json
{
  "key": "X-Content-Type-Options",
  "value": "nosniff"
},
{
  "key": "X-Frame-Options",
  "value": "DENY"
},
{
  "key": "X-XSS-Protection",
  "value": "1; mode=block"
},
{
  "key": "Referrer-Policy",
  "value": "strict-origin-when-cross-origin"
}
```

---

## CI/CD (GitHub Actions — Recommended)

```yaml
# .github/workflows/deploy.yml
name: Deploy to Firebase
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.44.x'
          channel: 'stable'
      - run: flutter pub get
      - run: dart analyze
      - run: dart format --set-exit-if-changed .
      - run: flutter test
      - run: flutter build web --release --web-renderer canvaskit --tree-shake-icons
      - uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: '${{ secrets.GITHUB_TOKEN }}'
          firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
          channelId: live
```
