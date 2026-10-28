# 🌐 Oraculum Web Sanctuary & Netlify Free Hosting Guide

This directory (`/website`) contains the official landing page, interactive Tarot card flipping demo, high-resolution app showcase, and Google Play compliance portals for **Oraculum: Sacred AI Tarot & Astral Guidance** (`com.tarotapp.tarot_app`).

---

## 📁 Website Architecture

| File | Purpose |
| :--- | :--- |
| [`index.html`](index.html) | Main sanctuary landing page: Hero, Interactive 3D Altar Demo, 5 Esoteric Pillars, High-Res Screenshot Carousel, Oracle Pro Pricing, and FAQs. |
| [`privacy.html`](privacy.html) | Official Privacy Policy & Google Play Data Safety disclosure page. |
| [`terms.html`](terms.html) | Terms of Service, In-App Billing disclosures, virtual currency rules, and liability disclaimers. |
| [`delete-account.html`](delete-account.html) | Google Play compliant Account & Data Deletion Portal with interactive submission form and data retention matrix. |
| [`styles.css`](styles.css) | Luxury obsidian (`#09080C`) and radiant gold (`#E2BE76`) design system with glassmorphism, responsive grids, and 3D card perspective. |
| [`script.js`](script.js) | Interactive starfield canvas animation, 3D card flip scrying engine (5 Major Arcana archetypes), mobile menu, and deletion form handler. |
| [`netlify.toml`](netlify.toml) | Netlify deployment settings, clean URL rewrite rules (`/privacy`, `/terms`, `/delete-account`), and strict security headers. |
| `images/` | High-res 512x512 app icons, 1024x500 feature graphic, and 1080x2400 in-app screenshots. |

---

## 🚀 How to Host for Free on Netlify

Netlify provides free static hosting with global SSL certificates, ultra-fast CDN edge distribution, and custom subdomains (`*.netlify.app`).

### Option 1: Drag & Drop (Zero Code • Fastest • 30 Seconds)
1. Log into your free account at [https://app.netlify.com/](https://app.netlify.com/).
2. Navigate directly to the Netlify Drop interface: **[app.netlify.com/drop](https://app.netlify.com/drop)**.
3. On your computer, open:
   `c:\Users\dreke\OneDrive\Desktop\TarotApp\`
4. Drag and drop the **`website`** folder directly into the browser window.
5. Netlify will deploy your site in ~3 seconds and give you a live URL!
6. **Your Live Website:**
   - Your live site is active at: **`https://oracalum.netlify.app`**!

---

### Option 2: Continuous Deployment via GitHub (Automated Updates)
Because we placed a root [`netlify.toml`](../netlify.toml) in the repository:
1. Push your latest code to your GitHub repository (`Dreke20/TarotApp`).
2. Go to **[app.netlify.com](https://app.netlify.com/)** and click **"Add new site" > "Import an existing project"**.
3. Authorize GitHub and select your **`TarotApp`** repository.
4. Netlify will automatically detect:
   - **Publish directory:** `website`
   - **Build command:** *(None needed)*
5. Click **"Deploy TarotApp"**.
6. Every time you push to GitHub, your live website and legal compliance pages will update automatically!

---

### Option 3: Deploy via Netlify CLI (Terminal)
If you prefer deploying via terminal:
```powershell
# Open terminal in the TarotApp folder
cd c:\Users\dreke\OneDrive\Desktop\TarotApp

# Run one-line production deploy
npx netlify-cli deploy --dir=website --prod
```
Log in when prompted by the browser, select **"Create & configure a new site"**, and the CLI will output your live URL.

---

## 📋 Google Play Console Store Links

Copy these exact links directly into your **Google Play Console**:

1. **Privacy Policy URL:**  
   `https://oracalum.netlify.app/privacy`
2. **Account Deletion URL:**  
   `https://oracalum.netlify.app/delete-account`
3. **Developer Website:**  
   `https://oracalum.netlify.app/`

