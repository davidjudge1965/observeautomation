---
date: "2026-05-17"
title: "Service Scope: Florist AI Voice Receptionist"
description: "What each tier of the ObserveAutomation AI Voice Receptionist for florists covers: call allowances, add-ons, response times, and licence terms."
categories: ["Scope"]
tags: ["Scope", "Receptionist", "Florist"]
image: "/image/FloristInShopOnPhone.webp"
hero_position: "center top"
draft: false
---

## Overview

This document sets out exactly what is covered by each tier of the **AI Voice Receptionist for Florists**, what is not, and what you can expect from us operationally. It is written to be honest and specific so there are no surprises later, and so that you can use it as a reference when something comes up.

The product itself is a 24/7 AI receptionist that answers the calls you cannot take, books appointments into your calendar, captures wedding and funeral enquiries, and filters out cold callers. The full product description is on the [Florist AI Voice Receptionist page](/products/floristreceptionist/).

Your fees in brief:

- **Two public tiers:** **Standard** at £499/month and **Plus** at £749/month. A **Lite** tier at £349/month is available by arrangement for low-volume sole traders.
- **Setup fee:** £500 (Standard), £750 (Plus), £350 (Lite). One-off.
- **Call and AI costs:** bundled into the monthly fee, up to your tier's allowance. Overage at £0.20 per minute beyond the cap.
- **You still pay separately:** your Hetzner server (£5 to £10/month, billed direct by Hetzner) and Google (free).
- **Annual prepay:** 10% off the monthly fee. Setup fee is charged as normal.

All prices are exclusive of VAT. VAT at 20% is added on invoices. UK business customers who are VAT-registered can typically reclaim it.

You own the server, the n8n workflow, your existing business phone number, all the call data, all the recordings, and the editable settings (FAQs and business config) we share with you. We hold the operational provider accounts (Twilio, VAPI, OpenAI / OpenRouter) so you receive a single monthly bill from us. The fuller explanation is on the [Why managed page](/why-managed/).

This document has four parts: what is included in your monthly fee, the call and minute allowance with overage rules, optional add-ons, and the operational terms that sit around the service (response times, fair use, cancellation, data protection, liability).

---

## Choose your tier

| | **Lite** (by arrangement) | **Standard** | **Plus** |
|---|---|---|---|
| Monthly fee | £349 | £499 | £749 |
| Setup fee (one-off) | £350 | £500 | £750 |
| Calls included per month | Up to 150 | Up to 400 | Up to 800 |
| Minutes included per month | Up to 400 | Up to 1,000 | Up to 2,000 |
| Overage beyond either cap | £0.20/minute | £0.20/minute | £0.20/minute |
| FAQ / hours / prices updates | Self-service portal (Phase 2) | OA-managed, 2 to 3 day SLA | OA-managed, 1 day SLA |
| SMS confirmation + 24hr reminder | Add-on £20/mo | Add-on £20/mo | **Included** |
| Outbound callback for missed callers | Not available | Add-on £40/mo | **Included** |
| CRM read (HubSpot / Pipedrive) | Not available | Add-on £60/mo | **Included** |
| Quarterly business review | Annual 15-min | Quarterly 30-min | Quarterly 45-min |
| Priority response SLA | 2 business days | 1 business day | 4 business hours |

Whichever cap is reached first (calls or minutes) triggers overage. Email alerts at 70%, 90%, and 100% give you time to act before overage kicks in.

---

## What is included in your monthly fee

### Continuous monitoring

Your AI Receptionist is watched continuously, so problems are caught and acted on before they turn into missed calls.

- **Workflow health checks** on your n8n instance, running every few minutes
- **Server (Hetzner) health and security patching** to keep the underlying infrastructure stable and current
- **API key and credential expiry alerts** across all the providers we manage on your behalf (Twilio, VAPI, OpenAI, OpenRouter), so credentials never quietly lapse
- **Inbound call success rate monitoring** so a degraded connection between Twilio and VAPI is spotted within minutes
- **Webhook failure detection** so a broken integration does not drop bookings silently
- **Provider balance management** on the accounts we hold for you, so there is no balance to top up on your side

If any of these fire, we act first and tell you what happened second. You should not be the person finding out a problem exists.

### Proactive maintenance

The platforms underneath your receptionist evolve constantly. Keeping pace with them is included.

- **n8n version upgrades** for security patches and feature releases, tested in staging before going to your instance
- **Hetzner operating system and security patches** applied on a managed cadence
- **AI model migrations** when OpenAI, Anthropic, or another provider deprecates an older model. The new model is regression-tested against a set of real call scenarios before being switched live
- **Voice provider (VAPI) updates** and regression testing
- **Google Calendar API changes** managed transparently

You do not need to track any of this. If something needs your attention (for example, signing into your own Google account to refresh a calendar OAuth token), we tell you exactly what to click.

### Minor changes (included tweaks)

Florist businesses change constantly. Bouquet prices move with the wholesale market, hours change for Valentine's and Mother's Day, you take on a wedding venue partnership, you stop offering same-day delivery on Sundays. All of these are included as minor changes in your monthly fee.

Examples of what counts as a minor change:

- **Pricing updates** for bouquets, arrangements, wedding consultations, funeral tributes, gift cards
- **Seasonal hours** for Valentine's Day, Mother's Day, Christmas, Easter, and trading hours around weddings season
- **New product lines or services** added (e.g., a subscription bouquet service or workshops)
- **Delivery zone changes** (e.g., adding a new postcode, removing a village from same-day delivery)
- **Holiday closures** and emergency closures (e.g., staff illness, snow days)
- **FAQ updates** (delivery times, returns policy, vase deposits, conditioning advice)
- **Tone and voice tweaks** (more formal for a funeral-focused enquiry, warmer for wedding consultations)
- **Updating staff names** the AI mentions, or transfer numbers for urgent calls
- **Changing email recipients** for booking summaries and call transcripts

On Plus you can also edit your FAQs directly through a dashboard we share with you, and changes are reflected on the very next call. On Lite and Standard we apply your changes within the tier's SLA.

### Communication and reporting

- **Monthly usage report** delivered by email: calls answered, minutes used against allowance, calendar bookings made, transfer rate, spam-call rejection rate, and any common questions trending up
- **Live customer dashboard** showing this-month-to-date calls, minutes, projected end-of-month, and a record of every call. Plus tier also includes a most-asked-questions panel and a direct view of where you are against your tier cap
- **Threshold alerts** by email at 70%, 90%, and 100% of either your call or minute cap, so you can decide whether to re-tier before paying overage
- **Customer change-log** maintained for your account. Every change made to your prompt, FAQ, or workflow is recorded with date and reason. If you ever want to know "when did we change how it handles wedding consultations?", we can tell you in seconds
- **Quarterly business review** call (length per tier; 15 minutes annual on Lite, 30 minutes quarterly on Standard, 45 minutes quarterly on Plus) to look at what is working, what could be tuned, and what is coming up in your business that the receptionist should be ready for
- **Email response** per the SLA below

### Compliance and best practice

- **GDPR alignment** is built in. You are the Data Controller for all call data, recordings, and customer details. We act as Data Processor on your documented instructions
- **Industry regulation updates** are tracked on your behalf: Ofcom rules on call recording, ICO guidance on personal data, and any changes that affect how the receptionist must behave
- **Annual call quality review:** we listen to a random sample of 20 or more calls each January, score them against a rubric (response accuracy, tone, escalation handling, GDPR-compliant data capture), and send you a written report with recommendations
- **Standard call recording disclosure** is built into the greeting so the system complies with UK call recording law from day one
- **Sub-processor disclosure:** we maintain a current list of every provider that processes data on your behalf (see Data protection section). You are notified before any change

### Seasonal preparation built in

Florist trade is famously seasonal. We prepare for the peaks rather than reacting to them.

- **Valentine's Day** (late January): pricing and availability are updated, the AI is briefed on delivery cut-offs, and a stress test is run against expected volumes
- **Mother's Day** (late February to mid-March): same treatment, plus any specific bouquet collection details
- **Wedding season** (April to October): the AI is tuned each year for any change in how you handle consultations, deposits, and lead times
- **Christmas** (November onwards): pricing, wreath options, delivery cut-offs, and any closure dates configured in advance

You do not need to send us a reminder. We will reach out before each peak with a short checklist of what you need to confirm.

### First-100-call review

In the first month after go-live, we listen to the first 100 real calls and tune the receptionist on the back of them. People ask things you did not anticipate during setup. We catch those patterns early and bake the answers into the FAQ. This is included in the setup fee but the work happens after go-live and is part of getting the system properly fitted to your business. A written summary is sent to you at the end of the first month.

---

## Your call and minute allowance

Each tier includes both a call cap and a minute cap. Whichever you reach first triggers overage.

| Tier | Calls included | Minutes included | Implied average per call |
|---|---|---|---|
| Lite | 150 | 400 | 2.7 min |
| Standard | 400 | 1,000 | 2.5 min |
| Plus | 800 | 2,000 | 2.5 min |

Calls are the metric you think in. Minutes are how the underlying cost actually works. We show both so you can see at a glance which one is binding for your call mix.

Wedding consultations tend to run longer than everyday order calls. If your call mix is structurally longer than 2.5 minutes average, your minute cap will bind before your call cap. We will flag this in your monthly report and suggest a re-tier if it becomes a pattern.

**Overage** is charged at £0.20 per minute beyond whichever cap is hit first. This is roughly £0.07 above our underlying cost; it is a fair-use catch, not a profit centre. The signal "you should be on a higher tier" matters more than the £25 to £100 of overage revenue from a busy month.

**70% / 90% / 100% alerts** are emailed automatically. The 70% alert is informational. The 90% alert suggests we have a conversation about re-tiering. The 100% alert tells you overage has started.

**Downgrade trigger:** if you run under 30% of your tier cap for three months running, we will suggest moving you to a smaller tier. We are not selling you more than you need.

---

## Add-ons (ongoing, monthly)

| Add-on | Monthly | Available on | Notes |
|---|---|---|---|
| SMS confirmation + 24hr reminder | £20 | Lite (add-on), Standard (add-on), Plus (included) | Sends an SMS confirmation when a booking is made and a reminder 24 hours before. Uses our bundled Twilio account; SMS costs absorbed |
| Outbound callback for missed callers | £40 | Standard (add-on), Plus (included). Not available on Lite | If a call drops or the caller does not leave details, the AI calls back on a scheduled cron. Requires the outbound calling capability and is enabled only when this add-on is active |
| CRM read (HubSpot or Pipedrive) | £60 | Standard (add-on), Plus (included). Not available on Lite | The AI checks your CRM for an existing record on each call so it can recognise returning customers. Read-only; we do not write back unless you commission that as a significant change |
| ElevenLabs voice upgrade | Cost passed through (typically £5 to £15) | All tiers, opt-in | Replaces our bundled VAPI voice with an ElevenLabs voice of your choice. Cost is consumption-based and currently passes through at cost |

Add-ons can be added or removed at any time with the next invoice pro-rated.

---

## Response time service-level agreement

| Issue type | Plus | Standard | Lite |
|---|---|---|---|
| Emergency (calls dropping, system down, AI giving wrong information) | 4 business hours | 1 business day | 2 business days |
| Non-emergency email request | 1 business day | 1 business day | 2 business days |
| Minor tweak (price, hours, FAQ update) | 1 business day | 2 to 3 business days | Self-service or 3 business days |
| Significant change (paid project) | Quoted with timeline | Quoted with timeline | Quoted with timeline |

**Support hours:** Monday to Friday, 9am to 5pm UK time, for non-emergency requests.

**Emergency monitoring:** 24/7 automated. If a critical alert fires outside business hours, action begins when an operator is reached. The system itself is monitored continuously even when no human is at a keyboard.

---

## What is not included (chargeable significant changes)

A change is "significant" if any of the following apply:

- It requires altering the workflow architecture (new nodes, new credentials, new external services)
- It integrates a new third-party service that is not already an add-on or part of your setup
- It rebuilds more than roughly 25% of the system prompt
- It introduces a new mode of operation that is not available as an add-on

Examples of significant changes (with indicative prices, all quoted formally before any work starts):

- **Adding payment processing during calls** (e.g., taking a deposit by card on the call) – typically £600 to £1,200
- **Adding new languages** (e.g., Welsh, Polish for multilingual customers) – typically £400 to £800 per language
- **Integrating a CRM other than HubSpot or Pipedrive** (e.g., a florist-specific system) – typically £400 to £1,000
- **Multi-shop routing** (different branches, different rules) – typically £600 to £1,500
- **Adding e-commerce checkout integration** (e.g., taking orders directly through the AI into your Shopify or WooCommerce store) – typically £800 to £1,500
- **Migrating from Google Calendar** to another booking platform (Calendly, Acuity, Timely) – typically £300 to £600
- **CRM write (the AI inserting records back into your CRM)** beyond the read-only add-on – typically £400 to £800

Every significant change is **tested in a staging environment first**, so your live receptionist is never put at risk during the upgrade.

---

## What is bundled into your monthly fee and what you still pay separately

We absorb the operational telephony and AI costs up to your tier's call and minute allowance:

- **Twilio:** phone number rental for the receptionist line and per-minute call costs
- **VAPI:** voice AI per-minute usage
- **OpenAI / OpenRouter:** LLM tokens for the conversation
- Any overage is charged at £0.20 per minute as described above

You still pay separately, billed direct by the provider:

- **Hetzner server** that hosts your n8n workflow: £5 to £10/month
- **Google account:** free (for calendar integration)

We send you a transparency line on each invoice showing the approximate value of the provider usage we absorbed for you that month, so you can see what your bundled fee is doing.

---

## Pass-through option

If you would rather hold the provider accounts yourself and pay providers direct (no bundling, no allowance, no overage), you can choose the **pass-through** arrangement instead. The monthly fee for pass-through is approximately 12.5% lower than the equivalent bundled tier. You see every provider bill yourself; we still manage everything else.

This appeals to technically-comfortable buyers who want full account sovereignty. Most buyers prefer bundled for the single-bill simplicity. We are happy with either.

To choose pass-through, raise it during your discovery call and we will quote.

---

## Your responsibilities as the customer

For the service to run smoothly, you commit to the following:

- **Notify us within 7 days of business changes** that affect call handling (price changes, hours changes, new services, staff changes, address changes), unless you are on Plus and edit them yourself
- **Pay our invoices within 14 days** of receipt
- **Respond to quality review feedback** within 14 days when we flag unusual patterns in the monthly report
- **Do not share access credentials externally** (server logins, the dashboard URL we share with you, your Google calendar OAuth). If you suspect a credential has been shared, tell us immediately so we can rotate it
- **Maintain your existing business phone number** at your current carrier (BT, Vodafone, or whoever) and keep the forward to our number active. If you change carriers, tell us in advance so we can reconfigure
- **Maintain domain registration** if you use a custom domain in your setup (most florists do not)

If you cannot meet one of these temporarily (e.g., you are away for two weeks during wedding season), tell us in advance and we will manage around it.

---

## Failover behaviour when a provider goes down

The receptionist depends on several providers. From time to time one of them has an outage. Here is exactly what happens.

- **If VAPI is down:** inbound calls are routed to voicemail with a specific message: "Sorry, we are experiencing a brief technical issue. Please leave your name, number, and what you are calling about, and we will get back to you as soon as possible." We are alerted within seconds, and we email or message you within 1 hour with status
- **If the primary LLM provider is down:** the AI assistant automatically falls back to a secondary model configured at setup, so calls continue to be answered. If both providers are down simultaneously, voicemail kicks in
- **If Google Calendar is unreachable:** the AI takes the booking details and emails you, rather than failing the call
- **If Twilio is down:** this is rare but it is a hard failure (the phone network itself is unreachable). Calls revert to whatever fallback your existing phone provider has configured

There are no silent failures. Every failover path is logged and reported.

---

## Fair use

Tier fees are set on the assumption that your business looks broadly like the band the tier is sized for. Specifically:

- **Up to roughly 20 minor changes per quarter** (typically averages 5 to 10)
- **System handles up to 5 concurrent calls** before queueing
- **Up to your tier's call and minute caps** before overage kicks in (per the table above)

These are trigger points for a conversation, not hard limits. If your business grows and you start hitting the next tier up regularly, we will flag it in your monthly report and propose moving you up well before it becomes a surprise.

---

## Pause option for seasonal businesses

For wedding-focused florists and businesses with strong off-seasons, the service can be paused for **up to 3 months per year** at a reduced **monitoring-only fee of £75/month**.

While paused:

- Monitoring continues, so when you switch back on, everything still works
- Tweaks pause (any change requests during the pause are queued until you resume)
- The phone line continues to accept calls, but the AI's behaviour swaps to a simple "we're currently closed for the season, back on [date]" message that takes brief details
- 30 minutes of inclusive air time per paused month covers occasional out-of-season calls. Beyond that, the £0.20 per minute overage applies
- Add-ons pause and resume with the main service

To pause, give us 14 days written notice. To resume, give us 7 days notice.

---

## Pricing change protections

We do not want you to worry about price creep. So this is in writing.

- **Your tier price is held for the first 12 months** from your go-live date
- **After 12 months, any price increase requires 60 days written notice**
- **Increases will not exceed UK CPI inflation** in any year, unless the scope of the service changes (e.g., you have asked us to add chargeable items that get folded into the base)

If our underlying providers (Twilio, VAPI, OpenAI, OpenRouter) raise their prices significantly mid-term, we reserve the right to pass through the change after 12 months. We absorb routine fluctuations in the meantime.

---

## Competitive neutrality

We will not onboard a direct florist competitor within **10 miles of your primary trading address** without your written consent. Your geography is protected.

Your call data, FAQ content, and system prompt are confidential. They are never used to train AI models, never shared with other customers, and never used to inform a pitch to a competitor. If you want a written confidentiality agreement on top of this, we will sign one.

---

## Showcase rights

We would like the option to feature your business **anonymously** as a case study. That means industry, problem, and outcome, with no business name and no identifying details.

We will always ask in writing before publishing anything. You can opt out at any time, for any reason, by emailing us. There is no penalty and no impact on the service.

---

## Cancellation and exit

- **Minimum term:** 3 months from go-live. This is to cover the onboarding investment, not to lock you in
- **Notice after minimum term:** 30 days written
- **What you keep:** all infrastructure you own (your Hetzner server), all call recordings, all data, all transcripts, your editable settings (FAQs and business config) in your own Airtable workspace, your existing business phone number at your existing carrier. You also receive an export of your call history and invoices from our records
- **What you keep using:** the n8n workflow itself, under a perpetual non-transferable licence for use inside your own business
- **What you cannot do:** sell the workflow, share it with another business, or sublicense it

If you decide to move to another provider or bring the service in-house, we will help you transition at our standard hourly rate of **£70/hour**. No lock-in tricks. If you want to leave, we make leaving easy.

---

## Acquisition or change of ownership

If your florist business is sold as a going concern, the workflow licence transfers with the business to the new owner. The licence is tied to the business, not to you personally.

What this means in practice: if you sell your shop to someone who will continue running it as a florist, they inherit the licence. They will need to take over the management contract directly with us (or end it). The licence cannot be extracted and sold separately. For example, a competitor cannot acquire just the workflow as part of an asset purchase.

---

## Data protection (UK GDPR)

- **You** are the **Data Controller** for all call data, recordings, customer details, and any personal data processed through the receptionist
- **ObserveAutomation** is the **Data Processor**, acting only on your documented instructions
- A standard Data Processing Agreement (DPA) is provided at engagement
- **Sub-processors** (providers that process your data on our behalf, under appropriate contracts): Twilio (telephony and SMS), VAPI (voice AI), OpenAI and OpenRouter (LLM tokens), Airtable (customer-facing settings and our operational records), Hetzner (your server), Google (calendar), Stripe (payments when we move to automated billing), FreeAgent (our books). The current list is maintained in your DPA and we notify you before any change
- **Call recordings are stored on your own Hetzner server.** We do not store copies
- **Retention periods** for call data are configurable. The default is 30 days for recordings, 12 months for transcripts. We will set these to whatever you instruct
- We **never share customer data** beyond the sub-processors listed above
- **Right to deletion:** you or your callers can request deletion at any time; we honour it within the GDPR timeline

If you receive a data subject access request from one of your customers, we will help you fulfil it within the GDPR timeline at no extra charge.

---

## Liability and disputes

- **Total liability is capped at 3 months of fees paid** (currently £1,047 on Lite, £1,497 on Standard, £2,247 on Plus). This is standard for managed services of this size
- **Professional indemnity insurance** is in place covering errors and omissions arising from our work
- **Disputes are handled in good faith first.** If we cannot resolve a dispute by direct conversation, we will agree to mediation before any escalation to legal action
- **English law applies.** Jurisdiction is the courts of England and Wales

---

## How to request changes

To keep things moving and prevent things falling through the cracks:

- **Minor tweak:** if you are on Plus, edit it yourself in the dashboard. Otherwise email us with the subject prefix `[TWEAK]` and a clear description. Example: `[TWEAK] Update bouquet pricing from 1 May`
- **Add or remove an add-on:** email us with the subject prefix `[ADDON]`. We confirm and your next invoice reflects the change pro-rated
- **Significant change:** email us with the subject prefix `[QUOTE]` and an outline of what you want. We will come back with a written quote and timeline within 3 business days
- **Emergency:** WhatsApp us directly. Used only for "calls are not being answered" or "the AI is saying something wrong right now" situations
- All requests are acknowledged within 1 business day. Action follows the SLA above.

---

## Questions?

If anything in this document is unclear or you want to discuss a specific scenario before signing on, please [get in touch](/contact/). We would rather have a 15-minute conversation now than a misunderstanding three months in.
