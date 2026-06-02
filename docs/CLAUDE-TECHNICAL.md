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

### Build options front matter — `build:`, not `_build:`
Hugo 0.145.0 (Jan 2025) renamed the page-level build-options key from `_build:` to `build:`. The leading underscore was deprecated and will be removed in a future release. The block contents (`list: never`, `render: never`, `publishResources: false`, etc.) are unchanged. Search the repo for `_build:` and rewrite to `build:` whenever a deprecation warning appears in `hugo server` output.

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
ShowCodeCopyButtons: true
draft: false
---
```

`ShowCodeCopyButtons: true` is a PaperMod parameter that adds a copy button to fenced code blocks. Harmless on pages without code, useful on any article that might gain a code block later — include it on every new article-style file by default.

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

## Shortcodes — collapse and mermaid

Two shortcodes added 2026-06-02 to support technical posts (used heavily by the homelab Rebuild-NN series).

### `collapse.html`

Wraps an inner markdown block in native `<details>/<summary>`. No JS — the browser handles the toggle. PaperMod's `ShowCodeCopyButtons` JS still attaches to inner `<pre>` elements; the copy button is wired even while the block is collapsed, and remains functional once expanded.

Usage — **percent form** so the inner content is processed as markdown (a code fence inside an angle-bracket shortcode is passed through verbatim and won't render):

```markdown
{{%/* collapse summary="Show full compose.yaml" */%}}
```yaml
services:
  tempo:
    image: grafana/tempo:2.6.1
```
{{%/* /collapse */%}}
```

Note the documentation-escape syntax (`{{%/*  */%}}`) only appears when *referring* to the shortcode inside another markdown file; the actual call site uses `{{% collapse %}}...{{% /collapse %}}` with no `/*  */`.

### `mermaid.html`

Renders an inline Mermaid diagram. Loads `mermaid@11` ESM from jsDelivr once per page on the first invocation, tracked via `Page.Scratch`. Theme is `neutral`, which adapts reasonably to both PaperMod's light and dark modes.

Usage — **angle-bracket form** so the diagram source is passed through unmodified (markdown processing would mangle the Mermaid arrows):

```markdown
{{</* mermaid */>}}
flowchart LR
    A[Producer] -->|HTTPS| B[Traefik]
    B --> C[(Backend)]
    classDef new stroke:#2e7d32,stroke-width:3px,fill:#c8e6c9;
{{</* /mermaid */>}}
```

The homelab Rebuild-NN series uses one mermaid diagram per post in a "The stack so far" section right after the `<!--more-->` cut-off, with each post highlighting its newly-added components via `:::new` and the `classDef new` style above. Keep layout consistent across the series (external producers left, monitor VM subgraph centre, dotted arrows for internal queries, solid arrows for HTTPS through Traefik) so the diagram visibly grows over the eight-post arc.

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
- Trades/generic: `WORKING_DAYS = 22`
- Florist: `WORKING_DAYS = 26` (6-day week)

The Receptionist moved to bundled-minute tier pricing on 2026-06-02, so trades and florist calculators no longer compute a separate per-minute call cost — `totalMonthlyCost = svcFee` and the breakdown panel shows a single "Total monthly cost" row plus a static note that AI minutes are bundled up to the tier's allowance. The generic `roi-calculator.html` is untouched and still on the old pass-through model (with `COST_PER_MIN = 0.13` and `AVG_CALL_MINS = 2.5`); it is not currently embedded on any page (`grep` content/ for `roi-calculator` to verify).

### Defaults by variant
| Variant | Std value | High value | Missed calls/day | High-value % | Svc fee |
|---|---|---|---|---|---|
| Florist | £50 | £800 | 10 | 10% | £499 |
| Trades | £150 | £1,500 | 4 | 10% | £499 |

Svc fee default is Standard-tier price (£499). Users on Lite or Plus override the field manually.

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

### Inline code chips
- `:not(pre) > code` — backtick-wrapped inline code in markdown renders as a tinted chip: `font-size: 0.95em`, monospace stack with `JetBrains Mono` / `SF Mono` / `Cascadia Code` / `Consolas` fallbacks, background `#eef3fb` (matches `.products-section`), text `#1f3a93` (navy), `padding: 0.15em 0.4em`, `border-radius: 4px`, `word-break: break-word` so long identifiers break cleanly. Selector deliberately excludes fenced code blocks. Added 2026-06-02 because bare monospace was reading as visually smaller than surrounding paragraph text.
