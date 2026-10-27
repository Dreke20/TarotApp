/* ==========================================================================
   ORACULUM - JAVASCRIPT INTERACTIONS & CELESTIAL ALTAR
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {
  initStarfield();
  initTarotAltarDemo();
  initMobileNav();
  initAccountDeletionForm();
});

// --- 1. Ambient Dynamic Starfield Canvas ---
function initStarfield() {
  const canvas = document.getElementById('star-canvas');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');

  let width = (canvas.width = window.innerWidth);
  let height = (canvas.height = window.innerHeight);

  window.addEventListener('resize', () => {
    width = canvas.width = window.innerWidth;
    height = canvas.height = window.innerHeight;
  });

  const stars = [];
  const numStars = Math.floor((width * height) / 9000);

  for (let i = 0; i < numStars; i++) {
    stars.push({
      x: Math.random() * width,
      y: Math.random() * height,
      size: Math.random() * 1.6 + 0.3,
      alpha: Math.random() * 0.7 + 0.2,
      speed: Math.random() * 0.015 + 0.005,
      direction: Math.random() > 0.5 ? 1 : -1,
      color: Math.random() > 0.3 ? '#E2BE76' : '#A855F7',
    });
  }

  function renderStars() {
    ctx.clearRect(0, 0, width, height);

    stars.forEach((star) => {
      star.alpha += star.speed * star.direction;
      if (star.alpha > 0.9) {
        star.alpha = 0.9;
        star.direction = -1;
      } else if (star.alpha < 0.15) {
        star.alpha = 0.15;
        star.direction = 1;
      }

      ctx.beginPath();
      ctx.arc(star.x, star.y, star.size, 0, Math.PI * 2);
      ctx.fillStyle = star.color;
      ctx.globalAlpha = star.alpha;
      ctx.shadowBlur = star.size * 3;
      ctx.shadowColor = star.color;
      ctx.fill();
    });

    ctx.globalAlpha = 1.0;
    requestAnimationFrame(renderStars);
  }

  renderStars();
}

// --- 2. Interactive Tarot Altar Demo ---
const TAROT_ARCHETYPES = [
  {
    numeral: 'X',
    title: 'THE WHEEL OF FORTUNE',
    icon: '☸️',
    headline: '✦ Cyclic Turning & Auspicious Momentum',
    prophecy:
      'Look deeply into the solitary eye of the Wheel, where cosmic forces realign mundane circumstances in your favor. A karmic cycle culminates today, dissolving stagnant barriers into kinetic forward motion. Surrender resisting the turn; you are being guided toward an unexpected windfall of clarity.'
  },
  {
    numeral: 'XVII',
    title: 'THE STAR',
    icon: '✨',
    headline: '✦ Channeled Hope & Celestial Rebirth',
    prophecy:
      'The sacred waters flow from above into the terrestrial pool of consciousness. After the turbulent storm of shadows, the eternal starlight of hope pours untamed clarity into your spirit. Trust your inner vision; your prayers have pierced the veil.'
  },
  {
    numeral: 'II',
    title: 'THE HIGH PRIESTESS',
    icon: '🌙',
    headline: '✦ Intuitive Veil & Sacred Secrets',
    prophecy:
      'Seated between the pillars of Boaz and Jachin, the Priestess invites you into the silence beyond logic. A secret current stirs beneath the surface of an ongoing dilemma. Do not rush into action; listen to what is spoken in the stillness of twilight.'
  },
  {
    numeral: 'XIX',
    title: 'THE SUN',
    icon: '☀️',
    headline: '✦ Solar Illumination & Sovereign Vitality',
    prophecy:
      'The solar chariot ascends into the zenith of victory. Shadows dissolve in the blinding radiance of truth and untethered vitality. Whatever was concealed or burdened with hesitation steps into victorious dawn.'
  },
  {
    numeral: 'I',
    title: 'THE MAGICIAN',
    icon: '🪄',
    headline: '✦ Alchemy of Will & As Above, So Below',
    prophecy:
      'With wand pointed to the heavens and index finger to the earth, the Magician bridges archetypal intention into physical form. You possess every element—Fire, Earth, Air, and Water—necessary to transform your present reality.'
  }
];

function initTarotAltarDemo() {
  const cardFlip = document.getElementById('interactive-tarot-card');
  const drawBtn = document.getElementById('draw-card-btn');
  const cardNumeral = document.getElementById('demo-card-numeral');
  const cardTitle = document.getElementById('demo-card-title');
  const cardIcon = document.getElementById('demo-card-icon');
  const headline = document.getElementById('demo-prophecy-headline');
  const prophecyText = document.getElementById('demo-prophecy-text');

  if (!cardFlip || !drawBtn) return;

  let currentIndex = 0;
  let isFlipped = false;

  function revealCard() {
    if (isFlipped) {
      // Flip back to face-down first
      cardFlip.classList.remove('is-flipped');
      isFlipped = false;
      drawBtn.textContent = '✦ CHANNELING THE STARS... ✦';
      drawBtn.disabled = true;

      setTimeout(() => {
        // Pick next card
        currentIndex = (currentIndex + 1) % TAROT_ARCHETYPES.length;
        const card = TAROT_ARCHETYPES[currentIndex];

        cardNumeral.textContent = card.numeral;
        cardTitle.textContent = card.title;
        cardIcon.textContent = card.icon;
        headline.textContent = card.headline;
        prophecyText.textContent = card.prophecy;

        // Flip to face-up
        cardFlip.classList.add('is-flipped');
        isFlipped = true;
        drawBtn.textContent = '✦ DRAW ANOTHER SACRED ARCHETYPE ✦';
        drawBtn.disabled = false;
      }, 400);
    } else {
      // First flip
      const card = TAROT_ARCHETYPES[currentIndex];
      cardNumeral.textContent = card.numeral;
      cardTitle.textContent = card.title;
      cardIcon.textContent = card.icon;
      headline.textContent = card.headline;
      prophecyText.textContent = card.prophecy;

      cardFlip.classList.add('is-flipped');
      isFlipped = true;
      drawBtn.textContent = '✦ DRAW ANOTHER SACRED ARCHETYPE ✦';
    }
  }

  cardFlip.addEventListener('click', revealCard);
  drawBtn.addEventListener('click', revealCard);
}

// --- 3. Mobile Navigation Menu Toggle ---
function initMobileNav() {
  const menuBtn = document.getElementById('mobile-menu-toggle');
  const navLinks = document.getElementById('nav-links');

  if (!menuBtn || !navLinks) return;

  menuBtn.addEventListener('click', () => {
    navLinks.classList.toggle('active');
  });

  navLinks.querySelectorAll('a').forEach((link) => {
    link.addEventListener('click', () => {
      navLinks.classList.remove('active');
    });
  });
}

// --- 4. Account Deletion Request Handler ---
function initAccountDeletionForm() {
  const form = document.getElementById('account-deletion-form');
  const confirmation = document.getElementById('deletion-confirmation');

  if (!form || !confirmation) return;

  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const email = document.getElementById('delete-email').value;

    form.style.display = 'none';
    confirmation.style.display = 'block';
    confirmation.innerHTML = `
      <div style="background: rgba(226, 190, 118, 0.1); border: 1px solid var(--gold-bright); padding: 24px; border-radius: 14px; text-align: center;">
        <h3 class="gold-text" style="font-size: 1.4rem; margin-bottom: 8px;">✦ Deletion Request Received ✦</h3>
        <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 12px;">
          Your request to purge account records and associated reading archives for <strong>${email}</strong> has been logged into our queue.
        </p>
        <p style="color: var(--text-muted); font-size: 0.85rem;">
          Under Google Play Data Safety policies and GDPR/CCPA regulations, all associated profile, reading, and transaction tokens will be permanently scrubbed within 30 days. A confirmation receipt has been dispatched.
        </p>
      </div>
    `;
  });
}
