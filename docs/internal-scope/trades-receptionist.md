# Internal Service Scope: Trades AI Voice Receptionist

**Status: Internal only — do not share with customers**

This is the operational companion to [`content/scope/trades-receptionist/index.md`](../../content/scope/trades-receptionist/index.md). The customer-facing doc states what we promise. This one states how we deliver it, what the chargeable changes actually cost in time, the onboarding checklist per customer, and the sales objection handling notes.

Keep this in sync with the customer-facing version when scope changes.

**Trades-specific risk:** the stakes on emergency call handling are higher than florist. A wedding consultation booked at the wrong time is correctable. A burst-pipe emergency that gets misrouted to voicemail can cost real money and put a customer in genuine difficulty. Operational care is higher.

---

## A. Operational SOPs (how we actually deliver the promises)

### Continuous monitoring

| Promise to customer | How we deliver | Escalation if standard process fails |
|---|---|---|
| Workflow health checks every few minutes | UptimeRobot pings the n8n webhook URL every 5 mins. Threshold: 3 consecutive fails. | Alert hits WhatsApp. SSH to Hetzner, `docker ps`, check n8n container logs, restart container. If still failing, check Hetzner status page; if Hetzner is fine, debug n8n config. For trades: emergency call routing is critical — if down for more than 30 mins, manually divert calls to customer's mobile while we fix. |
| Server health and security patching | Hetzner monitoring agent on the box. `unattended-upgrades` enabled for security packages. Weekly check of `apt list --upgradable`. | If a patch breaks something: rollback to previous version, document the incident, retry in 7 days. |
| API key / credential expiry alerts | n8n workflow runs weekly probe of each credential (Twilio test API call, VAPI auth check, OpenAI ping, Google OAuth refresh). Calendar reminders 30 days before known expiry dates. | If a credential is failing, immediately email customer with exact provider URL and the single click they need to make. |
| Inbound call success rate | VAPI dashboard checked daily. Threshold: any call recorded with "system error" or duration <5 sec at scale (more than 2 in a day). | Pull the failed call log, check what node failed in n8n, fix or escalate to VAPI support. For trades: also check transfer success rate (emergency transfers must reach the customer or fallback mobile). |
| Webhook failure detection | n8n execution log monitored for failed webhook executions. Slack/WhatsApp alert if more than 1 failure in a 5-min window. | Investigate which integration failed (typically Google Calendar, sometimes Twilio). Check provider status page. |
| Account balance alerts | Twilio sub-account auto-checks balance daily via API. Customer alerted at 25%, 10%, and 5% of typical monthly spend. | If balance hits zero and we missed it, the calls fall back to voicemail. We owe the customer an explanation and an apology. For trades: this is high impact during cold snap season. |

### Proactive maintenance

| Promise to customer | How we deliver | Notes |
|---|---|---|
| n8n version upgrades | Test in staging environment first (separate Hetzner box, replica setup). Run a fixed regression test (book a boiler service, transfer an emergency, decline a sales call, capture a leak callout). If all pass, apply to customer instance during a low-traffic window. | Window: Tuesday 6am UK time generally. For trades, never deploy on Friday afternoon — weekend emergencies are the worst time for an issue to surface. |
| Hetzner OS patches | Monthly `apt update && apt upgrade` scheduled via cron on a Sunday morning. Reboot only if kernel update requires it. | If reboot is required, schedule with customer 48hrs in advance. For trades operating 24/7 emergency: confirm a 5-min window is acceptable. |
| AI model migrations | When a model is deprecated, run the regression test set against the new model. Critical scenarios: emergency triage (gas leak, flooding, no heat in winter); routine quote enquiry; sales-call rejection. Document the change in the customer change-log. | Track OpenAI deprecation announcements. Don't wait until the last week. |
| VAPI updates | Subscribe to VAPI changelog. Test new versions against the assistant config monthly. | |
| Google Calendar API changes | Subscribe to Google Workspace developer announcements. | Currently uses Calendar API v3; watch for v4 transition. |

### Minor changes (included tweaks)

- **Receive request:** Email with `[TWEAK]` prefix, or WhatsApp for urgent business changes (e.g., "I just put my prices up, AI is still quoting old prices")
- **Acknowledge:** Within 1 business day. Reply with "received, will be live by [date]"
- **Make change:** Edit in n8n. Update relevant FAQ document or system prompt section.
- **Test:** Run a test call through the staging assistant. Verify the change works as expected.
- **Deploy:** Apply to production assistant.
- **Log:** Record in the customer change-log with date, what changed, why (customer's exact request), and confirmation that it tested OK.
- **Confirm with customer:** Email confirming the change is live, with one-line instructions to verify themselves.

### Communication and reporting

| Item | How we deliver | Cadence |
|---|---|---|
| Monthly usage report | Generate from n8n logs + Twilio API + VAPI API. Template document populated automatically where possible. Manual review of "common questions trending up" and "emergency transfer rate" sections. | First week of each month, for previous month. |
| Customer change-log | Maintained in a private Notion page per customer. Each entry: date, description, requester, before/after, test result. | Updated at the time of every change. |
| Quarterly business review | Calendly link sent to customer. 30-min call. Agenda template: what's working, what's not, what's coming up, fee/scope review. For trades: also review emergency call handling specifically. | Every 90 days from go-live. Calendar reminder. |
| Email response within 1 business day | Acknowledge first, action second. Use the `[TWEAK]` / `[QUOTE]` prefix in subject when replying. | Always. |
| Emergency response within 4 business hours | WhatsApp first response, then full email follow-up. | When the customer reports a critical issue. |

### Compliance and best practice

- **GDPR:** Standard Data Processing Agreement template lives in `templates/dpa-template.md`. Send when customer asks or when handling sensitive data is part of the scope.
- **Industry regulation:** Subscribe to ICO and Ofcom newsletters. Monthly review of "anything that affects voice AI in call handling". Trades-specific: Gas Safe communications, electrical safety regulator updates.
- **Annual call quality review:** First week of January each year. Pull 20 random call recordings from VAPI dashboard. Score against the rubric, with extra weight on emergency triage accuracy. Write up findings in customer's monthly report template. Allow 2 hours per customer.
- **Call recording disclosure:** Built into the VAPI assistant's greeting. Verify on every assistant deploy.

### Seasonal preparation (trades-specific)

| Peak | Lead time | Checklist |
|---|---|---|
| Cold snap (Oct-Mar, especially first frost) | Start 1 October | Confirm emergency call-out availability, surcharge rules, typical lead times for boiler repairs vs replacements. Stress-test against 3-5x normal volumes. Brief the AI on the difference between "no hot water" (urgent) and "no heating in winter" (emergency). |
| Summer heatwave | Start 1 June (for aircon/electrical trades) | Brief on heat-related electrical issues (overloaded boards, fan failures). |
| Storm season (autumn/winter) | Start 1 October (for roofers, builders, electricians) | Storm damage triage. Distinguish between "tile loose, no immediate danger" and "water coming through ceiling". |
| Christmas / New Year | Start 1 November | Closure dates, emergency-only operation, agreed cover with other tradespeople. |

**Reminder mechanism:** Calendar entries on the operator's calendar, tied to each customer.

### First-100-call review

- **Trigger:** Calendar reminder 30 days after go-live, OR when VAPI shows 100+ calls handled (whichever comes first)
- **Process:** Listen to all 100 calls at 2x speed. For trades, pay special attention to: callers describing emergencies in their own language; AI's triage decisions (transfer vs message); spam call rejection effectiveness; tone (professional but friendly, not robotic).
- **Output:** Updated FAQ document, updated system prompt, customer report summarising findings.
- **Time budget:** ~6 hours per customer.

---

## B. Chargeable change pricing menu (with internal time estimates)

| Change type | Customer price | Internal estimate (hours) | Notes |
|---|---|---|---|
| Add SMS booking confirmation | £200 | 3 | Standard pattern, reusable. |
| Add SMS appointment reminder (24hr before) | £250 | 4 | Adds scheduled n8n workflow. |
| Add "engineer en route" SMS update | £300 | 5 | Triggered manually or from CRM status change. |
| Add payment processing on call (deposit) | £800 | 12 | Stripe integration. Recommend Stripe Checkout link via SMS instead of card-on-call (PCI safer). |
| Add Welsh language support | £500 | 8 | Prompt translation + voice testing. |
| Add Polish language support | £500 | 8 | Same as Welsh. |
| Integrate ServiceM8 | £800 | 14 | Common request. Standard API integration. |
| Integrate Tradify | £800 | 14 | Similar to ServiceM8. |
| Integrate Jobber | £800 | 14 | Similar. |
| Integrate Xero (auto-create invoice from booking) | £700 | 12 | Standard pattern. |
| Integrate QuickBooks | £700 | 12 | Similar to Xero. |
| Add Gas Safe verification flow | £800 | 12 | Bespoke compliance dispatch logic. |
| Add multi-engineer routing (2-3 engineers) | £900 | 14 | Routing logic + per-engineer specialism rules. |
| Add multi-engineer routing (4+) | £1,500 | 22 | Bespoke architecture; quote based on actual setup. |
| Add emergency dispatch with on-call rota | £1,000 | 16 | Time-of-day routing + escalation chain. |
| Add CRM (HubSpot/Pipedrive) | £600 | 10 | Standard CRM integration pattern. |
| Add CRM (bespoke or unfamiliar) | £1,000 | 16+ | Discovery first; quote may move. |
| Add WhatsApp Business as inbound channel | £600 | 10 | Bridge from WhatsApp to existing voice flow. |
| Voice provider migration (VAPI to alternative) | £600 | 10 | Includes new prompt tuning. |
| Migrate from Google Calendar to ServiceM8 calendar | £400 | 6 | |
| Add outbound calling (callback requests) | £800 | 12 | Compliance overhead (Ofcom rules). |
| Add full outbound campaign capability | £1,500 | 22 | Includes call list management, opt-out handling. |

**Hourly rate for unlisted items:** £70/hour.

**Quote validity:** 30 days from issue.

**Payment terms:** 50% upfront for projects over £500. Balance on completion.

---

## C. Per-customer onboarding checklist (Trades)

Customer name: _______________
Business address: _______________
Trade type: _______________ (plumber / electrician / heating engineer / etc.)
Go-live target date: _______________

### Pre-setup (1 week before)
- [ ] Customer has signed engagement letter
- [ ] Setup fee invoice issued
- [ ] Customer has provided FAQ source content (call-out fee, hourly rate, area covered, services offered, equipment serviced, payment methods)
- [ ] Customer has chosen receptionist tone preference (professional / friendly / direct)
- [ ] Emergency escalation number confirmed (typically customer's personal mobile)

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
- [ ] Configure emergency escalation: AI can transfer to customer's mobile for genuine emergencies
- [ ] Test the divert from a real phone, including the emergency transfer

### Voice AI setup
- [ ] Create VAPI assistant on customer's VAPI account
- [ ] Apply trades-specific system prompt (from template)
- [ ] Customise: business name, hours, location, services, hourly rate, call-out fee, areas covered, emergency definitions
- [ ] Configure call recording disclosure in greeting
- [ ] Set transfer rules: explicit emergencies (gas leak, flooding, no heat in winter, total power loss), known customer escalations, specific keywords
- [ ] Configure spam-call rejection (lead-gen, cold sales, surveys)
- [ ] Test 6 scenarios: routine quote, boiler service booking, gas leak emergency, flooding emergency, sales-call rejection, "are you Gas Safe registered" type compliance check

### Calendar integration
- [ ] Connect Google Calendar (or ServiceM8 / Tradify if customer prefers) via n8n OAuth
- [ ] Test booking creation
- [ ] Test availability lookup
- [ ] Test emergency slot handling (different rules than routine)

### Monitoring setup
- [ ] Set up UptimeRobot monitor for n8n webhook
- [ ] Set up Twilio balance alert webhook
- [ ] Configure customer change-log Notion page
- [ ] Add customer to QBR rolling 90-day calendar reminder
- [ ] Add customer to annual call quality review calendar (first week January)
- [ ] Add customer to seasonal prep reminders (cold snap, summer, storm, Christmas as applicable)

### Go-live
- [ ] Customer training call (30 min): how to view calls, how to request changes, who to contact, what counts as emergency
- [ ] Send welcome pack (branded PDF including scope doc + login details)
- [ ] First test call from customer's own phone
- [ ] Test emergency escalation specifically (call the AI, declare an emergency, confirm it transfers to customer's mobile)
- [ ] Activate divert from customer's phone provider
- [ ] First 7 days: daily check-in for issues, especially emergency handling

### Post go-live
- [ ] 30 days after go-live: first-100-call review (or when 100 calls hit, whichever sooner). Pay extra attention to emergency triage accuracy.
- [ ] 90 days after go-live: first QBR
- [ ] 365 days after go-live: first annual call quality review

---

## D. Sales objection handling notes

Pair each common objection with the scope clause that addresses it.

### "What if you raise the price after a year?"
**Reference:** Clause 10 — Pricing change protections.
**Response:** "I've put this in writing precisely so you don't have to worry about it. The £300/month is held for the first 12 months. After that, any change requires 60 days notice and won't exceed UK CPI inflation unless you've asked me to add new chargeable items into the base. That's a contractual cap, not a promise."

### "What if you take on another plumber/electrician in my area?"
**Reference:** Clause 11 — Competitive neutrality.
**Response:** "I won't take on another tradesperson in your specific trade within 10 miles of your address without your consent. Your geography is protected in writing. Your FAQs and prompts are also confidential — they never feed into AI training and never get shared."

### "What if I want to leave after a year? Can I take it with me?"
**Reference:** Clause 13 — Cancellation and exit.
**Response:** "Yes. The infrastructure is yours, the call data is yours, the phone number is yours. The workflow stays under a perpetual non-transferable licence in your business. If you want to move providers or bring it in-house, I'll help you transition at £70/hour. There's no lock-in. The minimum 3-month term is just to cover the onboarding work, not to trap you."

### "What if there's a real emergency and the AI gets it wrong?"
**Reference:** Clause 7 (failover), Clause 1 (monitoring), and the trades-specific transfer rules.
**Response:** "Emergencies are the highest-priority case. The AI is configured to recognise specific emergency phrases — gas leak, flooding, no heat in winter, total power loss — and transfer the caller straight through to your mobile. The first-100-call review specifically tunes this. If a real emergency goes to voicemail by mistake, that's the worst-case scenario I work hardest to prevent. The annual call quality review listens specifically for emergency triage accuracy."

### "What if VAPI or OpenAI goes down? My phone will be silent."
**Reference:** Clause 7 — Failover behaviour.
**Response:** "If VAPI is down, calls route to voicemail with a specific message that includes your emergency mobile number for genuine emergencies. If OpenAI is down, the AI automatically falls back to a secondary provider I configure at setup. You're alerted within an hour either way. No silent failures."

### "What's actually a 'minor tweak' and what isn't? I don't want to be nickel-and-dimed."
**Reference:** Clause 2 (included tweaks) and Clause 4 (chargeable significant changes).
**Response:** "Anything that's a change to existing behaviour — rates, hours, FAQ, service area, tone, what the AI says — is included. The chargeable side is when you want new capability: adding SMS, payment processing, ServiceM8 integration, multi-engineer routing. The test is: does it change architecture, integrate new services, or rebuild the prompt significantly? If yes, I quote. If no, it's free under the monthly fee. There's a list of examples in the scope doc."

### "What about my customer data? Is it secure?"
**Reference:** Clause 15 — Data protection.
**Response:** "You're the Data Controller, I'm the Data Processor. Call recordings sit on your own Hetzner server, not mine. I don't store copies. Retention periods are configurable — default 30 days for recordings, 12 months for transcripts. I can sign a Data Processing Agreement if you want one in writing."

### "What if you go on holiday and the AI breaks?"
**Reference:** Clause 1 (continuous monitoring), Clause 7 (failover).
**Response:** "Monitoring runs 24/7 automatically. Critical alerts hit me on WhatsApp wherever I am. Failovers happen automatically: VAPI down means voicemail with your emergency mobile; LLM down means secondary provider. I plan holiday cover with customers in advance, and the monitoring continues regardless."

### "Why £300/month? I've seen voice AI for £50/month."
**Reference:** Clause 2 (full included list), and the [Why managed page](/why-managed/).
**Response:** "£50/month tools give you the AI itself. £300/month covers monitoring, maintenance, ongoing tweaks, AI model migrations, quarterly business reviews, annual call quality review, seasonal preparation for your peaks (cold snap, storms). For trades, where a misrouted emergency call costs real money, the difference matters. If you want the AI alone, you can build it yourself — but you'll spend more time managing it than you'd save on the tools."

### "What if my business is sold? Does the licence go with it?"
**Reference:** Clause 14 — Acquisition or change of ownership.
**Response:** "Yes, if it's sold as a going concern. The licence is tied to the business, not to you personally. The new owner inherits it and they'd take over the management contract. It can't be extracted as an asset and sold separately."

### "If the AI mishandles an emergency, are you liable?"
**Reference:** Clause 16 — Liability and disputes.
**Response:** "Liability is capped at 3 months of fees paid, currently £900. That's standard for managed services this size. I carry professional indemnity insurance. In practice, the AI is configured to err on the side of escalating emergencies to you rather than handling them itself. The first-100-call review is specifically designed to catch any cases where the AI didn't escalate when it should have."

### "Can you guarantee uptime?"
**Reference:** Clause 1 (monitoring) and Clause 7 (failover).
**Response:** "I don't offer a contractual uptime SLA at this fee level because half the dependencies are yours — Twilio, VAPI, OpenAI, Google. What I do offer is continuous monitoring, automatic failover, and 4-hour emergency response. In practice this is highly available. If you want a contractual uptime SLA — say 99.9% — that's a custom engagement with redundancy at every layer, and the fee goes up to cover it."

### "Will it really filter out spam and lead-gen calls?"
**Reference:** Clause 2 (included tweaks, ongoing FAQ updates).
**Response:** "Yes. Lead-gen companies, cold sales, surveys, insurance pitches — all redirected to email or politely declined. The first-100-call review tunes this on your actual incoming spam patterns. If a new spam pattern emerges, that's a minor tweak — I update the system to handle it, no extra charge."
