# ObserveAutomation — Project Context for Claude Code

## About this project

Personal portfolio and product site for ObserveAutomation, built with **Hugo** (static site generator). Hosted at **https://www.observeautomation.com**, source managed in this GitHub repository.

The owner is building a consultancy around **AI and automation for small businesses**, primarily using **n8n** as the automation platform combined with various LLMs. The site serves as a portfolio to attract clients.

---

## Site structure

### Sections and layouts

| Section | List layout | Single layout | Notes |
|---|---|---|---|
| `/products/` | `layouts/products/list.html` | `layouts/products/single.html` | Card grid + signposts |
| `/services/` | `layouts/services/list.html` | — | Hero + 6 service cards + signposts |
| `/portfolio/` | `layouts/portfolio/list.html` | `layouts/_default/single.html` | Card grid + signposts |
| `/blog/` | `layouts/blog/list.html` | `layouts/_default/single.html` | Card grid with post dates + signposts |
| `/homelab/` | `layouts/homelab/list.html` | `layouts/homelab/single.html` | Card grid + signposts |
| `/about/` | — | `layouts/about/single.html` | Circular photo + content |
| `/contact/` | — | `layouts/contact/single.html` | Form + GDPR notice |
| Homepage | `layouts/index.html` | — | Hero + how-it-works + product cards + signposts |

### Navigation order
Home · Products · Services · Portfolio · Blog · Homelab · About · Contact

### Key layout pattern
All section list pages share the same structure:
1. Hero image with title overlay (uses `image` and `hero_position` front matter)
2. Intro text from `_index.md` content
3. Card grid iterating `.Pages`
4. Two signpost CTA cards at the bottom

### `hero_position` front matter param
Controls `background-position` on hero images. E.g. `hero_position: "center top"` prevents heads being cropped. Defaults to `center` if omitted.

---

## Key files

### Images (all in `static/image/`)
- `ProductsHeroPhoto.jpg` — Products section hero
- `PortfolioHeroPhoto.jpg` — Portfolio section hero
- `HomelabHeroPhoto.jpg` — Homelab section hero
- `ServicesHeroPhoto.jpg` — Services section hero
- `BlogHeroPhoto.jpg` — Blog section hero
- `BusyTradespersonWhilePhoneRinging.jpg` — Trades Receptionist product hero
- `FloristInShopOnPhone.jpg` — Florist Receptionist product hero
- `OA_Logo_Square.jpg` — 720×720 square logo crop (Google Business Profile)

### Product pages (`content/products/`)
- `FloristReceptionist/index.md` — Florist AI Voice Receptionist (live)
- `TradesReceptionist/index.md` — Trades AI Voice Receptionist (live)
- `AI Voice Receptionist/index.md` — Original receptionist page (`draft: true`, hidden)

### Shortcodes (`layouts/shortcodes/`)
- `roi-calculator.html`, `roi-calculator-florist.html`, `roi-calculator-trades.html` — ROI calculators
- `audio-player.html` — Styled audio player (`{{< audio-player src="..." title="..." >}}`)

---

## Pricing model (AI Voice Receptionist)

- **Setup fee**: £500 (one-off)
- **Monthly management fee**: from £200/month
- **Call/AI costs**: Passed through at cost — £0.13/min, ~2.5 min avg = ~£0.33/call
- **Minimum contract**: 3 months, then rolling monthly

---

## Target market

Primary verticals for the AI Voice Receptionist:
- **Florists** — standard order £50, weddings £thousands, funerals £600–£1,000
- **Trades** — plumbers, electricians, heating engineers (£110–£1,500 per job)
- **Salons and pet services** — booking-dependent businesses
- **Independent retailers** — flooring shops, etc.

---

## Content and tone guidelines

- **Products/portfolio/blog**: Write for sceptical small business owners. Lead with pain and cost, not features. Concrete £ figures. Short punchy sentences. No jargon.
- **Homelab**: Unabashedly technical. Audience is fellow tinkerers and organisations evaluating technical depth.
- **British English always**: "organise" not "organize", "recognise" not "recognize", "colour" not "color", etc.
- **No em-dashes** (—): use a comma, colon, or restructure the sentence instead.
- Audio demo: `static/media/OA_Receptionist_Example_Call.mp3` — always link on receptionist product pages
- Audio shortcode: `{{< audio-player src="media/OA_Receptionist_Example_Call.mp3" title="Hear the AI receptionist in action" >}}`

---

## SEO status

### Phase 1 — Technical foundations (complete)
- `enableRobotsTXT = true`, GA4 active (ID: `G-4BN5LK4X9N`), Search Console registered 2026-02-01
- Open Graph + Twitter Card tags, meta descriptions, LocalBusiness schema — all in `baseof.html`, validated in Rich Results Test
- `html lang="en-GB"`

### Phase 2 — Keyword strategy (defined)
Primary targets: `AI voice receptionist UK`, `AI receptionist for florists UK`, `AI receptionist for tradespeople UK`, `business automation Milton Keynes`
Local towns: Leighton Buzzard, Milton Keynes, Aylesbury

### Phase 3 — Meta descriptions (complete)
All pages have unique keyword-rich descriptions: Homepage (hugo.toml), Florist, Trades, Products, Portfolio, Services, Homelab, About, Contact, Blog.

### Phase 4 — Blog (in progress)
- Post 1: `missed-calls-tradespeople` — live 2026-03-25
- Post 2: `missed-calls-florists` — live 2026-03-27
- Post 3: `email-sorting-automation` — live 2026-04-01
- Post 4: invoice/receipt processing — deferred (automation being rewritten)

### Phase 5 — Local SEO (largely complete)
- Google Business Profile live; description, hours (by appointment), logo (OA_Logo_Square.jpg) all set
- Categories: "IT support and services" (primary, still wrong) + "Business management consultant"
- Address (town/region only) and telephone to be added to schema when ready

---

## Pending / next steps

- **Blog post 4**: Invoice/receipt processing — wait for automation rewrite
- **Google Business Profile**: Fix primary category ("IT support and services" is not accurate)
- **Homelab articles**: Review content and layout — user needs to create artefacts first
- **"Monitoring n8n in my lab"**: Needs a better hero image (AI-generated image prompt available)
- **Schema**: Add phone number and full address when test number is retired

---

@docs/CLAUDE-TECHNICAL.md
