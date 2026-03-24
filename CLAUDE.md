# ObserveAutomation — Project Context for Claude Code

## About this project

This is the personal portfolio and product site for ObserveAutomation, built with **Hugo** (static site generator). The site is hosted at **https://www.observeautomation.com** and the source is managed in this GitHub repository.

The owner is building a consultancy around **AI and automation for small businesses**, primarily using **n8n** as the automation platform combined with various LLMs. The site serves as a portfolio to attract clients.

---

## Hugo setup

- **Framework**: Hugo with a custom theme
- **Config file**: `hugo.toml` (or `config.toml`) in the project root
- **Content directory**: `content/`
- **Layouts directory**: `layouts/`
- **Shortcodes**: `layouts/shortcodes/`
- **Static assets**: `assets/` (images, media)
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
layout: "single"
image: "/image/image-filename.png"
draft: false
---
```

---

## Key files

### Product pages
- `content/products/AI Voice Receptionist/index.md` — live AI Voice Receptionist page (original)
- `content/products/ReceptionistV2/index.md` — rewritten AI Voice Receptionist page (in progress)

### Shortcodes
- `layouts/shortcodes/roi-calculator.html` — ROI calculator widget (embedded in product pages)

### Layouts
- `layouts/_default/single.html` — single page layout
- `layouts/_default/baseof.html` — base layout

---

## The ROI Calculator

A self-contained HTML/CSS/JS widget embedded via Hugo shortcode. Key details:

- **Shortcode call**: `{{< roi-calculator >}}`
- **File**: `layouts/shortcodes/roi-calculator.html`
- **Scoping**: All CSS must be scoped to `#oa-roi-calc` to prevent styles leaking into the surrounding page. The outer div has `id="oa-roi-calc"` and every CSS rule is prefixed with `#oa-roi-calc`.
- **Styling**: Dark theme (`#0f1117` background), amber accent (`#ffb632`), DM Serif Display + DM Sans fonts via Google Fonts

### Calculator inputs
- Standard order / job value (£)
- High-value order value (£) — e.g. wedding/funeral for florists
- Estimated missed calls per day (slider, 1–30)
- % of calls that are high-value (slider, 0–50%)
- Monthly management / service fee (£)

### Calculator outputs
- Monthly revenue at risk
- Annual revenue at risk
- Cost breakdown (management fee + call costs)
- Total monthly cost vs. revenue at risk ratio
- Dynamic verdict message
- Disclaimer + "Book a free consultation" CTA linking to `/contact`

### Call cost constants (in the JS)
```javascript
const COST_PER_MIN  = 0.13;   // £0.13 per minute
const AVG_CALL_MINS = 2.5;    // average call length
const WORKING_DAYS  = 22;     // working days per month
```

### Future variants planned
- `roi-calculator-florist.html` — pre-filled with florist defaults (£60 standard, £800 high-value)
- `roi-calculator-trades.html` — pre-filled with trades defaults

---

## Pricing model (AI Voice Receptionist)

- **Setup fee**: £500 (one-off)
- **Monthly management fee**: £200–£300/month depending on complexity
- **Call/AI costs**: Passed through at cost — £0.13/min, ~2.5 min avg = ~£0.33/call
- **Typical total monthly cost**: £260–£400/month all-in
- **Minimum contract**: 3 months, then rolling monthly

---

## Target market

Primary verticals for the AI Voice Receptionist:
- **Florists** — high value missed calls (standard £60, weddings £thousands, funerals £600–£1,000)
- **Trades** — plumbers, electricians, heating engineers (£110–£1,200 per job)
- **Salons and pet services** — booking-dependent businesses
- **Independent retailers** — flooring shops, etc.
- **Pubs and hospitality** — lower ROI case, value is time-saving not revenue protection

---

## Content and tone guidelines

- Write for **sceptical small business owners**, not tech enthusiasts
- Lead with **pain and cost**, not technology features
- Use **concrete £ figures** wherever possible
- Avoid jargon — "answers your calls" not "AI-powered voice automation"
- The audio demo recording is at `media/OA_Receptionist_Example_Call.mp3` — always link to it on the product page
- Audio shortcode format: `{{<audio src="media/OA_Receptionist_Example_Call.mp3" title="AI Voice Receptionist Example Call">}}`

---

## Current work in progress

1. **ReceptionistV2 page** — rewritten product page being tested at `/products/receptionistv2/`. Once approved it will replace the live page at `/products/ai-voice-receptionist/`.
2. **ROI calculator** — embedded in ReceptionistV2. CSS scoping issues have been resolved using `#oa-roi-calc` ID. The calculator is working correctly.
3. **New hero image** — the current robot sketch image needs replacing with a professional photo. Owner is generating one via Midjourney/DALL-E. Suggested prompt: *"Professional photo of a friendly receptionist at a modern small business front desk answering a phone, warm lighting, shallow depth of field, no text, clean background — commercial photography style"*
4. **Vertical-specific pages** — future pages targeting florists, trades, etc. each with a tailored calculator variant.
