/**
 * ══════════════════════════════════════════════════════════════════════════════
 * Fazal-e-Haq Portfolio — Splash Screen Controller
 * Orchestrates the charcoal sketch intro, 2-second hold, and divider expansion.
 * ══════════════════════════════════════════════════════════════════════════════
 */
(function() {
  'use strict';

  const splash = document.getElementById('splash-container');
  const content = document.querySelector('.splash-content');
  const divider = document.querySelector('.splash-divider');
  const seoContent = document.getElementById('seo-content');

  if (!splash) return;

  let isExpanding = false;
  let isDone = false;
  let flutterReady = false;

  // Mark flutter ready when engine renders first frame
  window.addEventListener('flutter-first-frame', function() {
    flutterReady = true;
  });

  /**
   * Timing Breakdown:
   * - 0.2s - 1.2s : Headline typing
   * - 1.25s - 1.75s: Divider draws
   * - 1.65s - 2.25s: Subtitle fades in
   * Total animation completes at ~2.25s.
   * User Request: "when text finish after 2 second expand that divider and show my intro"
   * So 2.25s + 2.0s = 4.25s (4250ms).
   */
  const HOLD_DURATION_MS = 4250;

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
   * Expands the hand-drawn divider into a full-screen #FDF0D5 portal,
   * parting the charcoal pencil background to reveal the Flutter introduction.
   */
  function triggerExpansion() {
    if (isExpanding || isDone) return;
    isExpanding = true;

    // 1. Gently fade out the headline and subtitle
    if (content) {
      content.classList.add('exiting');
    }

    // 2. Expand the divider into full-screen sketchbook paper
    if (divider) {
      divider.classList.add('expanding');
    }

    // 3. Complete transition and clean up after expansion animation (850ms)
    setTimeout(function() {
      finishSplash();
    }, 850);
  }

  function finishSplash() {
    if (isDone) return;
    isDone = true;

    if (seoContent) {
      seoContent.style.display = 'none';
      seoContent.setAttribute('aria-hidden', 'true');
    }

    if (splash && splash.parentNode) {
      splash.style.opacity = '0';
      setTimeout(function() {
        if (splash.parentNode) {
          splash.remove();
        }
        window.dispatchEvent(new CustomEvent('splash-removed'));
      }, 300);
    }
  }

  // Fallback safety timeout (ensure splash never stays stuck past 8 seconds)
  setTimeout(function() {
    if (!isDone) {
      finishSplash();
    }
  }, 8000);
})();
