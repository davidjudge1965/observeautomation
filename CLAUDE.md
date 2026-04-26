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
| `/portfolio/` | `layouts/portfolio/list.html` | `layouts/portfolio/single.html` | Card grid + signposts; single pages end with a 2-card CTA signpost |
| `/blog/` | `layouts/blog/list.html` | `layouts/_default/single.html` | Card grid with post dates + signposts |
| `/homelab/` | `layouts/homelab/list.html` | `layouts/homelab/single.html` | Card grid + signposts |
| `/about/` | — | `layouts/about/single.html` | Circular photo + content |
| `/contact/` | — | `layouts/contact/single.html` | Form + GDPR notice |
| Homepage | `layouts/index.html` | — | Hero + 5-card "Common problems" grid (services-grid CSS) + product cards + signposts |

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
- `EmailTriageHero.jpeg` — Email Triage product hero
- `OA_Logo_Square.jpg` — 720×720 square logo crop (Google Business Profile)

### Product pages (`content/products/`)
- `TradesReceptionist/index.md` — Trades AI Voice Receptionist (live, weight: 10)
- `FloristReceptionist/index.md` — Florist AI Voice Receptionist (live, weight: 20)
- `LatePaymentChasing/index.md` — Late Payment Chasing automation (live, weight: 30)
- `EmailTriage/index.md` — Email Triage automation (live, weight: 40)
- `AI Voice Receptionist/index.md` — Original generic receptionist page (`draft: true`, hidden)

### Shortcodes (`layouts/shortcodes/`)
- `roi-calculator.html`, `roi-calculator-florist.html`, `roi-calculator-trades.html` — ROI calculators
- `audio-player.html` — Styled audio player (`{{< audio-player src="..." title="..." >}}`)

---

## Pricing model

### AI Voice Receptionist (Florist and Trades)
- **Setup fee**: £500 (one-off)
- **Monthly management fee**: from £200/month
- **Call/AI costs**: Passed through at cost — £0.13/min, ~2.5 min avg = ~£0.33/call
- **Minimum contract**: 3 months, then rolling monthly

### Late Payment Chasing
- **Setup fee**: £350 (one-off)
- **Monthly management fee**: £100/month (up to 20 invoice reminders)
- **No per-transaction AI costs**
- **Minimum contract**: 3 months, then rolling monthly

### Email Triage
- **Setup fee**: £300 (one-off); +£300 for automatic draft replies feature
- **Monthly management fee**: £150/month
- **AI costs**: £0.01–£0.10 per email, passed through at cost
- **Minimum contract**: 3 months, then rolling monthly

### General principles (applies to all products)
- All products run on **customer-owned infrastructure**: customer has their own Hetzner (or equivalent) VPS and their own API accounts (Twilio, VAPI, OpenAI, OpenRouter, etc.). ObserveAutomation does not host on shared hardware — this is against n8n's terms of service for self-hosted multi-tenant deployments.
- **Workflow IP belongs to ObserveAutomation**. Customers receive a non-transferable licence to use the workflow in their own business indefinitely, including after the engagement ends. They may not share, sell, or sublicense the workflow.
- AI/API costs are always passed through at cost, with no markup, on the customer's own provider bills.

---

## Target market

Primary audience: **any SMB owner** spending time on tasks that could be automated. The site positioning is "AI and automation for small businesses" — not receptionist-specific.

Key verticals with specific product fit:
- **Florists** — AI Voice Receptionist; standard order £50, weddings £thousands, funerals £600–£1,000
- **Trades** — AI Voice Receptionist; plumbers, electricians, heating engineers (£110–£1,500 per job)
- **Any business that invoices clients** — Late Payment Chasing
- **Any SMB owner with a busy inbox** — Email Triage
- **Salons and pet services** — booking-dependent, good fit for Voice Receptionist
- **Independent retailers** — automation consulting and bespoke builds

---

## Content and tone guidelines

- **Products/portfolio/blog**: Write for sceptical small business owners. Lead with pain and cost, not features. Concrete £ figures. No jargon.
- **Sentence length**: Vary sentence length within paragraphs. A single short sentence lands hard after a longer one — but never open a paragraph with multiple consecutive short sentences or fragments. Complete sentences always; fragments only in H2 callout headers.
- **Homelab**: Unabashedly technical. Audience is fellow tinkerers and organisations evaluating technical depth.
- **British English always**: "organise" not "organize", "recognise" not "recognize", "colour" not "color", etc.
- **No em-dashes** (—): use a comma, colon, or restructure the sentence instead.
- **Positioning line**: "I remove manual work and reduce costs by automating bottlenecks." — use as an opener on about, services, and homepage.
- Audio demo: `static/media/OA_Receptionist_Example_Call.mp3` — always link on receptionist product pages
- Audio shortcode: `{{< audio-player src="media/OA_Receptionist_Example_Call.mp3" title="Hear the AI receptionist in action" >}}`

---

## SEO status

### Phase 1 — Technical foundations (complete)
- `enableRobotsTXT = true`, GA4 active (ID: `G-4BN5LK4X9N`), Search Console registered 2026-02-01
- Open Graph + Twitter Card tags, meta descriptions, LocalBusiness schema — all in `baseof.html`, validated in Rich Results Test
- `html lang="en-GB"`

### Phase 2 — Keyword strategy (defined, partially updated)
Original targets: `AI voice receptionist UK`, `AI receptionist for florists UK`, `AI receptionist for tradespeople UK`, `business automation Milton Keynes`
Broader targets added with repositioning: `AI automation for small businesses UK`, `email automation small business`, `invoice chasing automation`
Local towns: Leighton Buzzard, Milton Keynes, Aylesbury

### Phase 3 — Meta descriptions (complete)
All pages have unique keyword-rich descriptions: Homepage (hugo.toml), Florist, Trades, Products, Portfolio, Services, Homelab, About, Contact, Blog.

### Phase 4 — Blog (complete)
- Post 1: `missed-calls-tradespeople` — live 2026-03-25
- Post 2: `missed-calls-florists` — live 2026-03-27
- Post 3: `email-sorting-automation` — live 2026-04-01
- Post 4: `invoice-processing-automation` — live 2026-04-26

### Phase 5 — Local SEO (largely complete)
- Google Business Profile live; description, hours (by appointment), logo (OA_Logo_Square.jpg) all set
- Categories: "IT support and services" (primary, still wrong) + "Business management consultant"
- Address (town/region only) and telephone to be added to schema when ready

---

## Pending / next steps

- **Google Business Profile**: Fix primary category ("IT support and services" is not accurate)
- **Homelab articles**: Review content and layout — user needs to create artefacts first
- **"Monitoring n8n in my lab"**: Needs a better hero image (AI-generated image prompt available)
- **Schema**: Add phone number and full address when test number is retired
- **SEO**: Meta descriptions for new Email Triage product page and updated homepage/services descriptions should be re-validated in Search Console after indexing

---

@docs/CLAUDE-TECHNICAL.md
