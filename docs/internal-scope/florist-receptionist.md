# Internal Service Scope: Florist AI Voice Receptionist

**Status: Internal only — do not share with customers**

This is the operational companion to [`content/scope/florist-receptionist/index.md`](../../content/scope/florist-receptionist/index.md). The customer-facing doc states what we promise. This one states how we deliver it, what the chargeable changes actually cost in time, the onboarding checklist per customer, and the sales objection handling notes.

Keep this in sync with the customer-facing version when scope changes.

---

## A. Operational SOPs (how we actually deliver the promises)

### Continuous monitoring

| Promise to customer | How we deliver | Escalation if standard process fails |
|---|---|---|
| Workflow health checks every few minutes | UptimeRobot pings the n8n webhook URL every 5 mins. Threshold: 3 consecutive fails. | Alert hits WhatsApp. SSH to Hetzner, `docker ps`, check n8n container logs, restart container. If still failing, check Hetzner status page; if Hetzner is fine, debug n8n config. |
| Server health and security patching | Hetzner monitoring agent on the box. `unattended-upgrades` enabled for security packages. Weekly check of `apt list --upgradable`. | If a patch breaks something: rollback to previous version, document the incident, retry in 7 days. |
| API key / credential expiry alerts | n8n workflow runs weekly probe of each credential (Twilio test API call, VAPI auth check, OpenAI ping, Google OAuth refresh). Calendar reminders 30 days before known expiry dates. | If a credential is failing, immediately email customer with exact provider URL and the single click they need to make. |
| Inbound call success rate | VAPI dashboard checked daily. Threshold: any call recorded with "system error" or duration <5 sec at scale (more than 2 in a day). | Pull the failed call log, check what node failed in n8n, fix or escalate to VAPI support. |
| Webhook failure detection | n8n execution log monitored for failed webhook executions. Slack/WhatsApp alert if more than 1 failure in a 5-min window. | Investigate which integration failed (typically Google Calendar, sometimes Twilio). Check provider status page. |
| Account balance alerts | Twilio sub-account auto-checks balance daily via API. Customer alerted at 25%, 10%, and 5% of typical monthly spend. | If balance hits zero and we missed it, the calls fall back to voicemail. We owe the customer an explanation and an apology. |

### Proactive maintenance

| Promise to customer | How we deliver | Notes |
|---|---|---|
| n8n version upgrades | Test in staging environment first (separate Hetzner box, replica setup). Run a fixed regression test (book a wedding consultation, get a quote, transfer an emergency). If all pass, apply to customer instance during a low-traffic window. | Window: Tuesday 6am UK time generally. |
| Hetzner OS patches | Monthly `apt update && apt upgrade` scheduled via cron on a Sunday morning. Reboot only if kernel update requires it. | If reboot is required, schedule with customer 48hrs in advance. |
| AI model migrations | When a model is deprecated, run the regression test set against the new model. Compare quality of responses side-by-side on 5 real customer scenarios. Document the change in the customer change-log. | Track OpenAI deprecation announcements. Don't wait until the last week. |
| VAPI updates | Subscribe to VAPI changelog. Test new versions against the assistant config monthly. | |
| Google Calendar API changes | Subscribe to Google Workspace developer announcements. | Currently uses Calendar API v3; watch for v4 transition. |

### Minor changes (included tweaks)

- **Receive request:** Email with `[TWEAK]` prefix, or WhatsApp for urgent business changes
- **Acknowledge:** Within 1 business day. Reply with "received, will be live by [date]"
- **Make change:** Edit in n8n. Update relevant FAQ document or system prompt section.
- **Test:** Run a test call through the staging assistant. Verify the change works as expected.
- **Deploy:** Apply to production assistant.
- **Log:** Record in the customer change-log with date, what changed, why (customer's exact request), and confirmation that it tested OK.
- **Confirm with customer:** Email confirming the change is live, with one-line instructions to verify themselves.

### Communication and reporting

| Item | How we deliver | Cadence |
|---|---|---|
| Monthly usage report | Generate from n8n logs + Twilio API + VAPI API. Template document populated automatically where possible. Manual review of "common questions trending up" section. | First week of each month, for previous month. |
| Customer change-log | Maintained in a private Notion page per customer. Each entry: date, description, requester, before/after, test result. | Updated at the time of every change. |
| Quarterly business review | Calendly link sent to customer. 30-min call. Agenda template: what's working, what's not, what's coming up, fee/scope review. | Every 90 days from go-live. Calendar reminder. |
| Email response within 1 business day | Acknowledge first, action second. Use the `[TWEAK]` / `[QUOTE]` prefix in subject when replying. | Always. |
| Emergency response within 4 business hours | WhatsApp first response, then full email follow-up. | When the customer reports a critical issue. |

### Compliance and best practice

- **GDPR:** Standard Data Processing Agreement template lives in `templates/dpa-template.md`. Send when customer asks or when handling sensitive data is part of the scope.
- **Industry regulation:** Subscribe to ICO and Ofcom newsletters. Monthly review of "anything that affects voice AI in call handling".
- **Annual call quality review:** First week of January each year. Pull 20 random call recordings from VAPI dashboard. Score against the rubric (see `templates/call-quality-rubric.md`). Write up findings in customer's monthly report template. Allow 2 hours per customer.
- **Call recording disclosure:** Built into the VAPI assistant's greeting. Verify on every assistant deploy.

### Seasonal preparation (florist-specific)

| Peak | Lead time | Checklist |
|---|---|---|
| Valentine's Day | Start 15 January | Confirm pricing, delivery cut-offs, available bouquet ranges, opening hours, any pre-orders policy. Stress-test against 3x normal volumes. |
| Mother's Day | Start 4 weeks before (varies by year) | Same as Valentine's. Plus any specific Mother's Day bouquet range. |
| Wedding season (April-October) | Start 1 March | Annual review of consultation booking policy, deposit handling, lead times, peak season surcharges. |
| Christmas | Start 1 November | Christmas wreath options, delivery cut-offs, closure dates, Boxing Day/New Year behaviour. |

**Reminder mechanism:** Calendar entries on the operator's calendar, tied to each customer.

### First-100-call review

- **Trigger:** Calendar reminder 30 days after go-live, OR when VAPI shows 100+ calls handled (whichever comes first)
- **Process:** Listen to all 100 calls at 2x speed. Note: callers asking questions the FAQ doesn't cover; AI giving incorrect or hesitant answers; transfer rules being too liberal or too tight; tone issues.
- **Output:** Updated FAQ document, updated system prompt, customer report summarising findings.
- **Time budget:** ~6 hours per customer.

---

## B. Chargeable change pricing menu (with internal time estimates)

| Change type | Customer price | Internal estimate (hours) | Notes |
|---|---|---|---|
| Add SMS booking confirmation | £200 | 3 | Standard pattern, reusable. Uses Twilio Messaging API. |
| Add SMS appointment reminder (24hr before) | £250 | 4 | Adds scheduled n8n workflow. |
| Add payment processing on call (deposit) | £800 | 12 | Stripe integration. Requires PCI consideration; recommend Stripe Checkout link sent via SMS instead of card-on-call. |
| Add Welsh language support | £500 | 8 | Prompt translation + voice testing. VAPI Welsh quality acceptable. |
| Add Polish language support | £500 | 8 | Same as Welsh. |
| Integrate Floranext / florist POS | £800 | 14 | Bespoke per POS. Get auth docs from customer first. |
| Integrate Shopify (read products, take orders) | £1,000 | 16 | Read-only product lookup is simpler (~£600). Full order placement is more work. |
| Integrate Calendly | £400 | 6 | Standard pattern. |
| Integrate Acuity | £400 | 6 | Standard pattern. |
| Add wedding consultation booking flow (multi-step) | £600 | 10 | Multi-turn conversation with deposit handling. |
| Add funeral order capture flow (sensitive tone) | £400 | 6 | Tone calibration is the bulk of the work. |
| Multi-shop routing (2-3 shops) | £800 | 12 | Routing logic + per-shop FAQ separation. |
| Multi-shop routing (4+) | £1,500 | 22 | Bespoke architecture; quote based on actual setup. |
| Email follow-up after every call | £300 | 5 | n8n flow + email template. |
| Add CRM (HubSpot/Pipedrive) | £600 | 10 | Standard CRM integration pattern. |
| Add CRM (bespoke or unfamiliar) | £1,000 | 16+ | Discovery first; quote may move. |
| Voice provider migration (VAPI to alternative) | £600 | 10 | Includes new prompt tuning. |
| Migrate from Google Calendar to Calendly/Acuity | £400 | 6 | |
| Add outbound calling (callback requests) | £800 | 12 | Compliance overhead (Ofcom rules). |
| Add full outbound campaign capability | £1,500 | 22 | Includes call list management, opt-out handling. |

**Hourly rate for unlisted items:** £70/hour.

**Quote validity:** 30 days from issue.

**Payment terms:** 50% upfront for projects over £500. Balance on completion.

---

## C. Per-customer onboarding checklist (Florist)

Customer name: _______________
Business address: _______________
Go-live target date: _______________

### Pre-setup (1 week before)
- [ ] Customer has signed engagement letter
- [ ] Setup fee invoice issued
- [ ] Customer has provided FAQ source content (price list, common questions, opening hours, delivery zones)
- [ ] Customer has chosen receptionist name and tone preference

### Infrastructure provisioning
- [ ] Provision Hetzner CX21 (or equivalent) on customer's Hetzner account
- [ ] Install Docker + n8n via Docker Compose
- [ ] Configure HTTPS via Caddy/Traefik
- [ ] Set up daily backups to Hetzner Storage Box
- [ ] Create n8n admin user, transfer to customer ownership
- [ ] Document the server access for customer (in welcome pack)

### Telephony setup
- [ ] Purchase or port Twilio number into customer's Twilio account
- [ ] Configure call routing: customer's existing line → divert on no-answer/busy → Twilio number
- [ ] Test the divert from a real phone

### Voice AI setup
- [ ] Create VAPI assistant on customer's VAPI account
- [ ] Apply florist-specific system prompt (from template)
- [ ] Customise: business name, hours, location, products, pricing, delivery zones, FAQ
- [ ] Configure call recording disclosure in greeting
- [ ] Set transfer rules (urgent enquiries, specific keywords)
- [ ] Test 5 scenarios: bouquet order, wedding enquiry, funeral order, opening hours question, sales spam

### Calendar integration
- [ ] Connect Google Calendar (or customer's chosen platform) via n8n OAuth
- [ ] Test booking creation
- [ ] Test availability lookup

### Monitoring setup
- [ ] Set up UptimeRobot monitor for n8n webhook
- [ ] Set up Twilio balance alert webhook
- [ ] Configure customer change-log Notion page
- [ ] Add customer to QBR rolling 90-day calendar reminder
- [ ] Add customer to annual call quality review calendar (first week January)
- [ ] Add customer to seasonal prep reminders (Valentine's, Mother's Day, Christmas)

### Go-live
- [ ] Customer training call (30 min): how to view calls, how to request changes, who to contact
- [ ] Send welcome pack (branded PDF including scope doc + login details)
- [ ] First test call from customer's own phone
- [ ] Activate divert from customer's phone provider
- [ ] First 7 days: daily check-in for issues

### Post go-live
- [ ] 30 days after go-live: first-100-call review (or when 100 calls hit, whichever sooner)
- [ ] 90 days after go-live: first QBR
- [ ] 365 days after go-live: first annual call quality review

---

## D. Sales objection handling notes

Pair each common objection with the scope clause that addresses it.

### "What if you raise the price after a year?"
**Reference:** Clause 10 — Pricing change protections.
**Response:** "I've put this in writing precisely so you don't have to worry about it. The £300/month is held for the first 12 months. After that, any change requires 60 days notice and won't exceed UK CPI inflation unless you've asked me to add new chargeable items into the base. That's a contractual cap, not a promise."

### "What if you take on a competitor in my town?"
**Reference:** Clause 11 — Competitive neutrality.
**Response:** "I won't take on another florist within 10 miles of your shop without your consent. Your geography is protected in writing. Your FAQs and prompts are also confidential. They never feed into AI training and never get shared."

### "What if I want to leave after a year? Can I take it with me?"
**Reference:** Clause 13 — Cancellation and exit.
**Response:** "Yes. The infrastructure is yours, the call data is yours, the phone number is yours. The workflow stays under a perpetual non-transferable licence in your business. If you want to move providers or bring it in-house, I'll help you transition at £70/hour. There's no lock-in. The minimum 3-month term is just to cover the onboarding work, not to trap you."

### "What if VAPI or OpenAI goes down? My phone will be silent."
**Reference:** Clause 7 — Failover behaviour.
**Response:** "If VAPI is down, calls route to voicemail with a specific message asking them to leave details. If OpenAI is down, the AI automatically falls back to a secondary provider I configure at setup. You're alerted within an hour either way. No silent failures."

### "What's actually a 'minor tweak' and what isn't? I don't want to be nickel-and-dimed."
**Reference:** Clause 2 (included tweaks) and Clause 4 (chargeable significant changes).
**Response:** "Anything that's a change to existing behaviour — prices, hours, FAQ, tone, what the AI says — is included. The chargeable side is when you want new capability: adding SMS, payment processing, a new CRM, multi-shop routing. The test is: does it change architecture, integrate new services, or rebuild the prompt significantly? If yes, I quote. If no, it's free under the monthly fee. There's a list of examples in the scope doc."

### "What about my data? Is it secure?"
**Reference:** Clause 15 — Data protection.
**Response:** "You're the Data Controller, I'm the Data Processor. Call recordings sit on your own Hetzner server, not mine. I don't store copies. Retention periods are configurable — default 30 days for recordings, 12 months for transcripts. I can sign a Data Processing Agreement if you want one in writing."

### "What if you go on holiday and the AI breaks?"
**Reference:** Clause 1 (continuous monitoring), Clause 7 (failover).
**Response:** "Monitoring runs 24/7 automatically. Critical alerts hit me on WhatsApp wherever I am. Failovers happen automatically: VAPI down means voicemail with a specific message; LLM down means secondary provider. I plan holiday cover with customers in advance, and the monitoring continues regardless."

### "Why £300/month? Other providers offer voice AI for £50/month."
**Reference:** Clause 2 (full included list), and the [Why managed page](/why-managed/).
**Response:** "£50/month tools give you the AI itself. £300/month covers monitoring, maintenance, ongoing tweaks, AI model migrations when providers deprecate older versions, quarterly business reviews, annual call quality review, seasonal preparation for your peaks. It's the difference between buying a car and having a car with a service plan. If you want the car alone, you can build the AI yourself — but you'll spend more time managing it than you'd save."

### "What if my business is sold? Does the licence go with it?"
**Reference:** Clause 14 — Acquisition or change of ownership.
**Response:** "Yes, if it's sold as a going concern. The licence is tied to the business, not to you personally. The new owner inherits it and they'd take over the management contract. It can't be extracted as an asset and sold separately — that's to stop a competitor buying just the workflow from an asset sale."

### "If the AI books a wedding consultation at the wrong time, are you liable?"
**Reference:** Clause 16 — Liability and disputes.
**Response:** "Liability is capped at 3 months of fees paid, currently £900. That's standard for managed services this size. I carry professional indemnity insurance. In practice, the AI never invents bookings — it only books what's on your calendar. If a booking is wrong, the call recording shows what was agreed and we can correct it quickly."

### "Can you guarantee uptime?"
**Reference:** Clause 1 (monitoring) and Clause 7 (failover).
**Response:** "I don't offer a contractual uptime SLA at this fee level because half the dependencies are yours — Twilio, VAPI, OpenAI, Google. What I do offer is continuous monitoring, automatic failover, and 4-hour emergency response. In practice this is highly available. If you want a contractual uptime SLA, that's a custom engagement and the fee goes up to cover the redundancy required."
