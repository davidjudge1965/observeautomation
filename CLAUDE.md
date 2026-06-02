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
| `/scope/` | — | `layouts/_default/single.html` | Service scope detail pages (Trades + Florist Receptionist). Auto-generated section index is suppressed via `content/scope/_index.md` with `build.render: never`; only the two child pages build. `/scope/` itself 301s to `/products/` via `static/_redirects`. |
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

### Shortcodes (`layouts/shortcodes/`)
- `roi-calculator.html`, `roi-calculator-florist.html`, `roi-calculator-trades.html` — ROI calculators
- `audio-player.html` — Styled audio player (`{{< audio-player src="..." title="..." >}}`)
- `collapse.html` — Click-to-expand wrapper around a markdown block, using native `<details>/<summary>` (no JS). Use the percent form so inner content renders as markdown: `{{% collapse summary="Show full compose.yaml" %}}...code fence...{{% /collapse %}}`. Plays fine with `ShowCodeCopyButtons`.
- `mermaid.html` — Inline Mermaid diagram via the `mermaid@11` ESM build from jsDelivr. Loads once per page on first invocation. Use the angle-bracket form so the inner block is passed through verbatim: `{{< mermaid >}}flowchart LR ... {{< /mermaid >}}`. Theme is `neutral`.

### Infrastructure
- `static/_redirects` — Cloudflare Pages redirect rules. Currently: `/pricing/` → `/products/` (catches stragglers from old links and Google index), `/scope/` → `/products/` (catches anyone hitting the now-suppressed section index). Add new path-level redirects here; Cloudflare Pages picks the file up at build time. Host-level redirects (e.g., non-www → www) live in the Cloudflare dashboard as Redirect Rules, not in this file.
- `wrangler.toml` — Cloudflare Pages build config. Build command `./build.sh`, output `./public`, 404 handling serves `public/404.html`.

---

## Pricing model

### AI Voice Receptionist (Florist and Trades)
Three tiers with AI minutes bundled into the monthly fee (the public default model):

| Tier | Monthly | Setup | Calls / month | Minutes / month |
|---|---|---|---|---|
| **Lite** (by arrangement, low-volume sole traders) | £349 | £350 | up to 150 | up to 400 |
| **Standard** (public starting tier) | £499 | £500 | up to 400 | up to 1,000 |
| **Plus** (public premium) | £749 | £750 | up to 800 | up to 2,000 |

- **Overage**: £0.20 per minute beyond either cap, with alerts at 70%, 90%, 100%
- **Pass-through option**: customer holds the Twilio / VAPI / LLM accounts and pays providers direct; monthly fee approximately 12.5% lower than the equivalent bundled tier. Mentioned in scope pages, not the default offer.
- **Minimum contract**: 3 months, then rolling monthly
- **Decided 2026-06-02**: bundled is default, pass-through is the alternative. Site reconciled across product pages, scope pages, ROI calculators, and blog mentions.

### Late Payment Chasing
- **Setup fee**: £350 (one-off)
- **Monthly management fee**: £150/month (up to 20 invoice reminders)
- **No per-transaction AI costs**
- **Minimum contract**: 3 months, then rolling monthly

### Email Triage
- **Setup fee**: £300 (one-off); +£300 for automatic draft replies feature
- **Monthly management fee**: £200/month
- **AI costs**: £0.01–£0.10 per email, passed through at cost
- **Minimum contract**: 3 months, then rolling monthly

### General principles (applies to all products)
- All products run on **customer-owned infrastructure**: customer has their own Hetzner (or equivalent) VPS. For Late Payment Chasing and Email Triage, customer also has their own API accounts (OpenAI, OpenRouter, etc.). For the Receptionist on the default bundled tiers, ObserveAutomation holds the Twilio / VAPI / LLM accounts and bills the customer a single fee; on the pass-through option, the customer holds those accounts directly.
- **Workflow IP belongs to ObserveAutomation**. Customers receive a non-transferable licence to use the workflow in their own business indefinitely, including after the engagement ends. They may not share, sell, or sublicense the workflow.
- AI/API costs for non-Receptionist products are passed through at cost, with no markup, on the customer's own provider bills. For Receptionist on bundled tiers, costs are absorbed into the monthly fee up to allowance with overage at £0.20/min. On the Receptionist pass-through option, costs flow direct from providers to customer.

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
- **Never use "footgun"** anywhere in published prose. Substitute trap, pitfall, snag, hazard, or rephrase. Applies to every register including homelab posts.
- **Never reference paths in the private `davidjudge1965/HomeLabMonitoring` repo** from published observeautomation posts — neither as `github.com/...` links (404 for public readers) nor as inline-code `stack/...` paths (the directory isn't shipped to observeautomation either). When a post needs to mention a workshop file, describe it by purpose ("the compose", "the Tempo config") and let the in-article code block do the work.
- **Homelab Rebuild-NN series uses cumulative "stack so far" Mermaid diagrams**. Each post opens with a `{{< mermaid >}}` flowchart of the lab at that point in the build, with new components highlighted via `classDef new stroke:#2e7d32,stroke-width:3px,fill:#c8e6c9`. Keep layout consistent across posts (external producers left, `Monitor VM` subgraph centre, dotted arrows for queries, solid for HTTPS through Traefik).
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
- Categories: "Business management consultant" (primary) + "Automation company" + "Business-to-Business service"
- Address (town/region only) and telephone to be added to schema when ready

### Phase 6 — Site audit cleanup (complete 2026-06-02)
Ahrefs site audit triage in one session. All red and yellow issues addressed:
- **Canonical domain**: Cloudflare Redirect Rule 301s `observeautomation.com` → `https://www.observeautomation.com/$1` with query string preserved (UTMs survive). Cleared the "Page in multiple sitemaps (51)" warning — every page had been listed under both www and non-www sitemaps.
- **`/pricing/` 404s**: removed the broken links from both scope pages (the pricing table sits inline above them) and added `static/_redirects` so external clickers get 301'd to `/products/`.
- **`/scope/` orphan**: Hugo was auto-generating an empty section index page with no inbound links. Suppressed via `content/scope/_index.md` with `build.render: never` and a 301 to `/products/` in `_redirects`.
- **Meta description lengths**: 11 descriptions trimmed under 160 chars (the four Rebuild-XX posts were the worst at 200–429 chars); 5 too-short descriptions expanded.
- **Title lengths**: 5 titles flagged by Ahrefs as too long (>70 char rendered) shortened to fit Google's display width.
- **Google indexing**: sitemap resubmitted in Search Console; URL Inspection + Request Indexing fired against homepage, all four product pages, and the updated blog post.

---

## Campaign tracking (UTM convention)

GA4 (`G-4BN5LK4X9N`) automatically captures UTM parameters. Every URL posted on a social platform should be tagged so we can attribute traffic to the specific post and link role.

**Format:**
```
?utm_source=<platform>&utm_medium=social&utm_campaign=<post-slug>&utm_content=<role>
```

**LinkedIn — always use these values:**
- `utm_source=linkedin`
- `utm_medium=social`
- `utm_campaign=<blog-post-slug>` (lowercase, matches the URL segment under `/blog/`)
- `utm_content` — where the link sits and what it points to:
  - `post` — link in the LinkedIn post body
  - `comment-blog` — comment link to the blog post
  - `comment-portfolio` — comment link to a portfolio page
  - `comment-product` — comment link to a product page
  - Extend with the `comment-<target>` shape as needed

**Apply to:** every link in `linkedin-version.md` files, every link posted manually to LinkedIn (post body, first comment, profile, DMs). Internal references inside the draft (e.g. "Source post:" notes that aren't being posted) stay untagged.

**Viewing in GA4:** Reports → Acquisition → Traffic acquisition (switch primary dimension to Session campaign), or Explore with Session campaign + Session manual ad content as rows, filtered by `Session source = linkedin`.

---

## Pending / next steps

- **Homelab articles**: Review content and layout — user needs to create artefacts first
- **"Monitoring n8n in my lab"**: Needs a better hero image (AI-generated image prompt available)
- **Schema**: Add phone number and full address when test number is retired
- **SEO**: Meta descriptions for new Email Triage product page and updated homepage/services descriptions should be re-validated in Search Console after indexing

---

@docs/CLAUDE-TECHNICAL.md
