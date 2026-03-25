# ObserveAutomation — Project Context for Claude Code

## About this project

Personal portfolio and product site for ObserveAutomation, built with **Hugo** (static site generator). Hosted at **https://www.observeautomation.com**, source managed in this GitHub repository.

The owner is building a consultancy around **AI and automation for small businesses**, primarily using **n8n** as the automation platform combined with various LLMs. The site serves as a portfolio to attract clients.

---

## Hugo setup

- **Framework**: Hugo with the **PaperMod** theme (largely overridden with custom layouts)
  - GitHub: https://github.com/adityatelange/hugo-PaperMod/
  - Wiki: https://github.com/adityatelange/hugo-PaperMod/wiki
- **Config file**: `hugo.toml` in the project root
- **Content directory**: `content/`
- **Layouts directory**: `layouts/`
- **Shortcodes**: `layouts/shortcodes/`
- **Static assets**: `static/` (images go in `static/image/`, referenced as `/image/filename`)
- **Local dev server**: `hugo server -D` — runs at `http://localhost:1313`

### Important Hugo config
Unsafe HTML rendering must be enabled for shortcodes with raw HTML to work:
```toml
[markup.goldmark.renderer]
  unsafe = true
```

### Front matter format (use this exact format for all content files)
```yaml
---
date: '2026-01-07'
title: 'Page Title'
description: "Page description here."
categories: ["Products"]
tags: ["Products", "n8n", "GenAI"]
image: "/image/image-filename.jpg"
hero_position: "center center"
draft: false
---
```

Note: `layout: "single"` is NOT needed for pages in sections that have their own `layouts/<section>/single.html`.

---

## Site structure

### Sections and layouts

| Section | List layout | Single layout | Notes |
|---|---|---|---|
| `/products/` | `layouts/products/list.html` | `layouts/products/single.html` | Card grid + signposts |
| `/portfolio/` | `layouts/portfolio/list.html` | `layouts/_default/single.html` | Card grid + signposts |
| `/homelab/` | `layouts/homelab/list.html` | `layouts/homelab/single.html` | Card grid + signposts |
| `/about/` | — | `layouts/about/single.html` | Circular photo + content |
| `/contact/` | — | `layouts/contact/single.html` | Form + GDPR notice |
| Homepage | `layouts/index.html` | — | Hero + how-it-works + product cards + signposts |

### Key layout pattern
All section list pages (products, portfolio, homelab) share the same structure:
1. Hero image with title overlay (uses `image` and `hero_position` front matter)
2. Intro text from `_index.md` content
3. Card grid iterating `.Pages`
4. Two signpost CTA cards at the bottom

### `hero_position` front matter param
Controls `background-position` on hero images. Set per page, e.g. `hero_position: "center top"` to prevent heads being cropped. Defaults to `center` if omitted.

---

## Key files

### Images (all in `static/image/`)
- `ProductsHeroPhoto.jpg` — Products section hero
- `PortfolioHeroPhoto.jpg` — Portfolio section hero
- `HomelabHeroPhoto.jpg` — Homelab section hero
- `BusyTradespersonWhilePhoneRinging.jpg` — Trades Receptionist product hero
- `FloristInShopOnPhone.jpg` — Florist Receptionist product hero

### Product pages (`content/products/`)
- `FloristReceptionist/index.md` — Florist AI Voice Receptionist page (live)
- `TradesReceptionist/index.md` — Trades AI Voice Receptionist page (live)
- `AI Voice Receptionist/index.md` — Original receptionist page (`draft: true`, hidden)

### Shortcodes (`layouts/shortcodes/`)
- `roi-calculator.html` — Generic ROI calculator (`{{< roi-calculator >}}`)
- `roi-calculator-florist.html` — Florist defaults (`{{< roi-calculator-florist >}}`)
- `roi-calculator-trades.html` — Trades defaults (`{{< roi-calculator-trades >}}`)
- `audio-player.html` — Styled audio player (`{{< audio-player src="..." title="..." >}}`)

---

## ROI Calculators

Three variants — generic, florist, trades. Each is a self-contained HTML/CSS/JS shortcode.

### CSS scoping
Each calculator is scoped to a unique ID to prevent style leakage:
- Generic: `#oa-roi-calc`
- Florist: `#oa-roi-calc-florist` (element IDs prefixed `fl-`)
- Trades: `#oa-roi-calc-trades` (element IDs prefixed `tr-`)

JS in each is wrapped in an IIFE with a uniquely named function.

### Shared constants
```javascript
const COST_PER_MIN  = 0.13;   // £0.13 per minute
const AVG_CALL_MINS = 2.5;    // average call length
```
- Trades/generic: `WORKING_DAYS = 22`
- Florist: `WORKING_DAYS = 26` (6-day week)

### Defaults by variant
| Variant | Std value | High value | Missed calls/day | High-value % | Svc fee |
|---|---|---|---|---|---|
| Florist | £60 | £800 | 10 | 10% | £200 |
| Trades | £150 | £1,500 | 4 | 10% | £200 |

---

## CSS conventions (`static/css/style.css`)

### Card image behaviour
- `.product-card img` — `object-fit: cover`, `object-position: center top` (for photos)
- `.product-grid--logos .product-card img` — `object-fit: contain`, `background: #f7f9ff`, `padding: 1.5rem` (for logo images, used in homelab)

Apply `product-grid--logos` class to the `.product-grid` div when cards contain logos rather than photos.

### Blockquote styling in `.product-body`
- `> text` (single blockquote) — blue left border panel (`#4facfe`)
- `>> text` (nested blockquote) — amber left border callout (`#ffb632`); outer wrapper is transparent via `:has(> blockquote)`

### Section panel colours
- `.how-it-works` — white background
- `.products-section` — `#eef3fb` (light blue-grey)
- `.signpost` — white background

---

## Pricing model (AI Voice Receptionist)

- **Setup fee**: £500 (one-off)
- **Monthly management fee**: from £200/month
- **Call/AI costs**: Passed through at cost — £0.13/min, ~2.5 min avg = ~£0.33/call
- **Minimum contract**: 3 months, then rolling monthly

---

## Target market

Primary verticals for the AI Voice Receptionist:
- **Florists** — standard job £60, weddings £thousands, funerals £600–£1,000
- **Trades** — plumbers, electricians, heating engineers (£110–£1,500 per job)
- **Salons and pet services** — booking-dependent businesses
- **Independent retailers** — flooring shops, etc.

---

## Content and tone guidelines

- **Products/portfolio**: Write for sceptical small business owners. Lead with pain and cost, not features. Concrete £ figures. No jargon.
- **Homelab**: Unabashedly technical. Audience is fellow tinkerers and organisations evaluating technical depth.
- Audio demo: `static/media/OA_Receptionist_Example_Call.mp3` — always link on receptionist product pages
- Audio shortcode: `{{< audio-player src="media/OA_Receptionist_Example_Call.mp3" title="Hear the AI receptionist in action" >}}`

---

## Pending / next steps

- Mobile responsiveness check across all changed pages
- Individual homelab article pages — review content and layout
- Individual portfolio article pages — review content and layout
- Navigation review
