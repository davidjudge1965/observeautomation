# ObserveAutomation — Technical Reference

Stable reference for ROI calculators, CSS conventions, and Hugo config details. Read this when working on those specific areas.

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

### Product page front matter — additional params
All product pages require these additional fields to populate the three partials injected by the layout:

```yaml
what_you_need:
  - "A **Hetzner** (or equivalent) cloud server account for your n8n instance"
  - "A **Twilio** account for your phone number and call routing"
  - "A **VAPI** account for the AI voice platform"
  - "A **Google** account for FAQ lookup and calendar availability"
what_you_need_costs: "£10–£20 per month"
```

- `what_you_need` — list of strings, rendered as `<ul>` with markdown (bold supported). Required per product; differs per product.
- `what_you_need_costs` — string, rendered inline in the closing sentence of the "What you will need" section. Omit if no ongoing third-party costs apply.

---

## Product page partials

Three partials are automatically injected after `{{ .Content }}` by `layouts/products/single.html`. They appear in this order: "What you will need", "What the monthly fee covers", "Ownership and licensing".

| Partial | File | Content |
|---|---|---|
| What you will need | `layouts/partials/product-what-you-need.html` | Reads `what_you_need` list and `what_you_need_costs` from front matter. Renders nothing if `what_you_need` is absent. |
| What the monthly fee covers | `layouts/partials/product-monthly-fee.html` | Static content, identical on all product pages. Covers monitoring, maintenance, n8n upgrades, LLM deprecation, AI costs on customer's own bill, included tweaks, no lock-in. |
| Ownership and licensing | `layouts/partials/product-ownership.html` | Static content, identical on all product pages. States customer owns infrastructure/data; ObserveAutomation owns workflow IP; non-transferable usage licence. |

These sections appear after the FAQ and CTA in the page content — they function as supporting transparency information rather than primary selling copy. Do not duplicate their content within the page markdown.

---

## ROI Calculators

Three variants — generic, florist, trades. Each is a self-contained HTML/CSS/JS shortcode in `layouts/shortcodes/`.

- `roi-calculator.html` — Generic (`{{< roi-calculator >}}`)
- `roi-calculator-florist.html` — Florist defaults (`{{< roi-calculator-florist >}}`)
- `roi-calculator-trades.html` — Trades defaults (`{{< roi-calculator-trades >}}`)

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
| Florist | £50 | £800 | 10 | 10% | £200 |
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

### Services grid
- `.services-grid` — 3-col responsive grid (2-col at tablet, 1-col at mobile)
- `.service-card` — white card, blue top border, box shadow
- `.service-icon` — large emoji icon
- `.service-audience` — blue italic text (target audience note)

### Blog
- `.post-date` — muted date display on blog cards
