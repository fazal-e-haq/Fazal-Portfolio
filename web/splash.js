/**
 * ══════════════════════════════════════════════════════════════════════════════
 * Fazal-e-Haq Portfolio — Splash Screen Controller
 * Orchestrates the rough blackboard intro, 2-second hold, and full-screen expansion.
 * ══════════════════════════════════════════════════════════════════════════════
 */
(function() {
  'use strict';

  const splash = document.getElementById('splash-container');
  const divider = document.querySelector('.splash-divider');
  const seoContent = document.getElementById('seo-content');

  if (!splash) return;

  // Check if splash was already presented in this session (e.g. page reload)
  // Support ?splash=true query parameter to force replay if needed
  const urlParams = new URLSearchParams(window.location.search);
  const forceSplash = urlParams.get('splash') === 'true';

  if (!forceSplash && sessionStorage.getItem('splashShown') === 'true') {
    if (splash && splash.parentNode) {
      splash.remove();
    }
    if (seoContent) {
      seoContent.style.display = 'none';
      seoContent.setAttribute('aria-hidden', 'true');
    }
    window.dispatchEvent(new CustomEvent('splash-removed'));
    return;
  }

  // Record that splash has been shown for this session
  try {
    sessionStorage.setItem('splashShown', 'true');
  } catch (_) {}

  let isExpanding = false;
  let isDone = false;
  let flutterReady = false;

  // Mark flutter ready when engine renders first frame
  window.addEventListener('flutter-first-frame', function() {
    flutterReady = true;
  });

  /**
   * Timing Breakdown:
   * - 0.2s - 1.2s : Headline typing finishes
   * - 1.2s - 1.65s: Divider draws
   * - 1.65s - 2.15s: Subtitle fades in
   * Total text & divider animation finishes at ~2.15s.
   * Hold for 2.0s after text finish: 2.15s + 2.0s = ~4.15s (4150ms).
   */
  const HOLD_DURATION_MS = 4150;

  const autoExpandTimer = setTimeout(function() {
    triggerExpansion();
  }, HOLD_DURATION_MS);

  // Allow visitor to click / tap or press key to advance immediately
  function onUserSkip(e) {
    if (isExpanding || isDone) return;
    clearTimeout(autoExpandTimer);
    triggerExpansion();
  }

  splash.addEventListener('click', onUserSkip, { passive: true });
  window.addEventListener('keydown', function(e) {
    if (e.key === ' ' || e.key === 'Enter' || e.key === 'Escape') {
      onUserSkip(e);
    }
  }, { passive: true });

  /**
   * Expands the hand-drawn divider both horizontally and vertically into a full-screen
   * #FDF0D5 paper canvas, parting the rough blackboard background to reveal the Flutter introduction.
   */
  function triggerExpansion() {
    if (isExpanding || isDone) return;
    isExpanding = true;

    // 1. Gently fade out the headline and subtitle
    const headline = document.querySelector('.splash-headline');
    const subtitle = document.querySelector('.splash-subtitle');
    if (headline) headline.classList.add('fade-out');
    if (subtitle) subtitle.classList.add('fade-out');

    // 2. Reparent divider directly to #splash-container to guarantee unconstrained full-screen expansion
    if (divider && splash) {
      splash.appendChild(divider);
      divider.classList.add('expanding');
    }

    // 3. Complete transition and clean up after expansion animation (900ms)
    setTimeout(function() {
      finishSplash();
    }, 900);
  }

  function finishSplash() {
    if (isDone) return;
    isDone = true;

    if (seoContent) {
      seoContent.style.display = 'none';
      seoContent.setAttribute('aria-hidden', 'true');
    }

    if (splash && splash.parentNode) {
      splash.style.transition = 'opacity 0.35s ease-out';
      splash.style.opacity = '0';
      setTimeout(function() {
        if (splash.parentNode) {
          splash.remove();
        }
        window.dispatchEvent(new CustomEvent('splash-removed'));
      }, 350);
    }
  }

  // Fallback safety timeout (ensure splash never stays stuck past 8 seconds)
  setTimeout(function() {
    if (!isDone) {
      finishSplash();
    }
  }, 8000);
})();
