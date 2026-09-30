# 🏁 Production Readiness Checklist

> The FINAL gate before deployment. Every box must be checked.
> No exceptions. No "we'll fix it in the next deploy."

---

## 🔒 Non-Negotiable (Must ALL Pass)

### Build & Deploy
- [ ] `flutter build web --release` completes without errors
- [ ] Build output size < 5MB total (< 2MB gzipped JS)
- [ ] Firebase deploy preview tested and verified
- [ ] All environment variables / configs are production values
- [ ] No debug flags enabled

### Performance
- [ ] Lighthouse Performance score ≥ 90
- [ ] First Contentful Paint < 1.5s
- [ ] Largest Contentful Paint < 2.5s
- [ ] Cumulative Layout Shift < 0.1
- [ ] Total load time < 3s on 4G connection
- [ ] No janky animations (all 60fps)

### Responsive Design
- [ ] Pixel-perfect at 375px (iPhone)
- [ ] Pixel-perfect at 768px (iPad)
- [ ] Pixel-perfect at 1440px (Desktop)
- [ ] Pixel-perfect at 1920px (Full HD)
- [ ] No horizontal scroll at any width
- [ ] No text overflow / truncation bugs
- [ ] No overlapping elements

### Cross-Browser
- [ ] Chrome (latest) — fully functional
- [ ] Firefox (latest) — fully functional
- [ ] Safari (latest) — fully functional
- [ ] Edge (latest) — fully functional
- [ ] Mobile Safari (iOS) — fully functional
- [ ] Mobile Chrome (Android) — fully functional

### Accessibility
- [ ] Lighthouse Accessibility score ≥ 90
- [ ] Keyboard navigation works end-to-end
- [ ] Screen reader announces content correctly
- [ ] All images have alt text / semantic labels
- [ ] Focus indicators visible on all interactive elements
- [ ] Color contrast passes WCAG AA

### Content
- [ ] All text is final (no lorem ipsum / placeholder)
- [ ] All links work (no 404s, no broken hrefs)
- [ ] Resume PDF downloads correctly
- [ ] Social media links open correct profiles
- [ ] Email link composes new email correctly
- [ ] Project screenshots are real and high-quality
- [ ] No typos or grammatical errors

### SEO
- [ ] Lighthouse SEO score ≥ 90
- [ ] Meta title and description set
- [ ] Open Graph tags configured
- [ ] Twitter Card tags configured
- [ ] Structured data (JSON-LD) present
- [ ] sitemap.xml is accurate
- [ ] robots.txt allows crawling
- [ ] Google verification meta tag present
- [ ] og:image preview looks good (test with debugger tools)

### Security
- [ ] HTTPS enforced
- [ ] Security headers configured (X-Frame-Options, etc.)
- [ ] No sensitive data in client-side code
- [ ] No API keys exposed in source

### Analytics (Optional but Recommended)
- [ ] Google Analytics / Firebase Analytics configured
- [ ] Privacy-compliant (no tracking without consent in EU)

---

## 🎯 Quality Bar Verification

### The Gut Check
- [ ] Would I be proud to send this to a potential employer? **YES**
- [ ] Does the hero make an instant impression? **YES**
- [ ] Does every section feel intentionally designed? **YES**
- [ ] Would a design-focused hiring manager be impressed? **YES**
- [ ] Does it feel as polished as brittanychiang.com? **YES**

### Peer Review (If Possible)
- [ ] Had at least one other person test the site
- [ ] Incorporated feedback on any confusing UX
- [ ] Verified on a real mobile device (not just browser devtools)

---

## 🚀 Deploy Steps

1. Merge `ultra-redesign` → `main`
2. Run full checklist one final time on `main`
3. `flutter build web --release --web-renderer canvaskit --tree-shake-icons`
4. `firebase deploy --only hosting`
5. Verify live site at production URL
6. Test all links on production
7. Share on LinkedIn / Twitter 🎉
