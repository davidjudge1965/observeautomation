# Late Payment Chasing — n8n Workflow Build Notes

## Post-import manual steps

After importing `late-payment-workflow-nocode.json` into n8n, the following must be set manually — they do not survive the import:

1. **Stage N: Set Email nodes (all 4)** — open each node and toggle **"Include Other Input Fields"** on. Without this, the downstream Send Email and Log nodes will not receive the invoice data.
2. **Get Reminder Log** — confirm **"Always Output Data"** is enabled (Settings tab). Required so the workflow continues when the sheet is empty.
3. **Credentials** — re-map all three credential types when prompted: Gmail account, Google Sheets account for David, Invoice Ninja Header Auth.

---

## Infrastructure

- **Invoice Ninja**: https://invoiceninja.lab.davidmjudge.me.uk (Docker, Traefik, Let's Encrypt)
- **Docker Compose location**: `~/invoiceninja/` on docker04
- **API token**: stored as `IN_API_TOKEN` in `~/invoiceninja/.env`
- **n8n credentials**: Gmail and Google Sheets already configured

---

## Google Sheets — Reminder Log

Create a sheet called **Invoice Reminder Log** with these columns:

| A: Invoice ID | B: Invoice Number | C: Client Name | D: Amount | E: Due Date | F: Stage | G: Sent At |

---

## n8n Workflow — Node by Node

### Overall flow
```
Schedule → Get Log (Sheets) → Build Log Lookup → Get Invoices (Invoice Ninja)
→ Filter Overdue → Determine Reminders to Send → Build Email → Send (Gmail) → Append to Log
```

---

### Node 1: Schedule Trigger
- Runs every day at **08:00**

---

### Node 2: Get Reminder Log
- Type: **Google Sheets — Read**
- Document: Invoice Reminder Log
- Sheet: Sheet1
- Returns all existing rows (used to know what reminders have already been sent)

---

### Node 3: Build Log Lookup *(Code)*
One job: convert sheet rows into a fast lookup object.

```javascript
// Build a lookup object so we can quickly check whether a reminder
// has already been sent for a given invoice + stage combination.
// Key format: "invoiceId_stage" e.g. "a1b2c3_7"
// Value: true (we only care whether the key exists)

const logRows = $input.all();
const lookup = {};

for (const row of logRows) {
  const invoiceId = row.json['Invoice ID'];
  const stage = row.json['Stage'];

  if (invoiceId && stage) {
    const key = `${invoiceId}_${stage}`;
    lookup[key] = true;
  }
}

// Output as a single item so downstream nodes can reference it
// using $('Build Log Lookup').first().json.lookup
return [{ json: { lookup } }];
```

---

### Node 4: Get Invoices from Invoice Ninja
- Type: **HTTP Request**
- Method: GET
- URL: `https://invoiceninja.lab.davidmjudge.me.uk/api/v1/invoices`
- Query params: `include=client`, `status_id[]=2`, `status_id[]=3`, `per_page=100`
  - Status 2 = Sent (unpaid), Status 3 = Partial
- Headers: `X-Api-Token: {{ $env.IN_API_TOKEN }}`

---

### Node 5: Filter Overdue Invoices *(Code)*
One job: keep only invoices past their due date and calculate days overdue.

```javascript
// Filter invoices to only those that are overdue (due date has passed).
// Also calculate how many days overdue each invoice is.
// Invoice Ninja returns all sent/partial invoices — we narrow it down here.

const today = new Date();
today.setHours(0, 0, 0, 0); // Compare dates only, not times

// Invoice Ninja wraps results in a 'data' array
const invoices = $input.first().json.data;
const overdueInvoices = [];

for (const invoice of invoices) {
  // Skip invoices with no due date set
  if (!invoice.due_date) continue;

  const dueDate = new Date(invoice.due_date);
  dueDate.setHours(0, 0, 0, 0);

  if (dueDate < today) {
    const msPerDay = 1000 * 60 * 60 * 24;
    const daysOverdue = Math.floor((today - dueDate) / msPerDay);

    overdueInvoices.push({
      json: {
        invoiceId:     invoice.id,
        invoiceNumber: invoice.number,
        clientName:    invoice.client?.name ?? 'Customer',
        clientEmail:   invoice.client?.contacts?.[0]?.email ?? null,
        amount:        invoice.balance,       // Outstanding balance, not total
        dueDate:       invoice.due_date,
        daysOverdue,
      }
    });
  }
}

return overdueInvoices;
```

---

### Node 6: Determine Reminders to Send *(Code)*
One job: for each overdue invoice, work out which reminder stages are due and not yet sent.

```javascript
// Reminder stages are triggered at these overdue thresholds (days):
// Stage 1  → send on day 1–6
// Stage 7  → send on day 7–13
// Stage 14 → send on day 14–29
// Stage 30 → send on day 30+
//
// Each stage is sent once. We check the lookup built from the Sheets log
// to skip any that have already gone out.

const STAGES = [1, 7, 14, 30];

// Retrieve the lookup from the earlier node
const { lookup } = $('Build Log Lookup').first().json;

const remindersToSend = [];

for (const item of $input.all()) {
  const invoice = item.json;

  // Skip invoices with no client email — nothing to send
  if (!invoice.clientEmail) continue;

  for (const stage of STAGES) {
    // This stage applies if the invoice is at least this many days overdue
    if (invoice.daysOverdue < stage) continue;

    // Check whether this reminder has already been sent
    const key = `${invoice.invoiceId}_${stage}`;
    if (lookup[key]) continue;

    // This reminder is due and hasn't been sent — queue it
    remindersToSend.push({
      json: { ...invoice, stage }
    });
  }
}

return remindersToSend;
```

---

### Node 7: Build Email Content *(Code)*
One job: construct subject line and body for each reminder based on its stage.

```javascript
// Each stage has a different tone:
// Stage 1  → friendly nudge
// Stage 7  → polite follow-up
// Stage 14 → direct request for payment or contact
// Stage 30 → final notice

const invoice = $input.first().json;

const formattedAmount = `£${parseFloat(invoice.amount).toFixed(2)}`;
const formattedDueDate = new Date(invoice.dueDate).toLocaleDateString('en-GB', {
  day: 'numeric', month: 'long', year: 'numeric'
});

const templates = {
  1: {
    subject: `Payment reminder — Invoice ${invoice.invoiceNumber}`,
    body: `
      <p>Hi ${invoice.clientName},</p>
      <p>Just a quick note to let you know that invoice ${invoice.invoiceNumber}
      for ${formattedAmount} was due on ${formattedDueDate}.</p>
      <p>If you've already arranged payment, please ignore this message.
      If you have any questions, just reply and we'll be happy to help.</p>
      <p>Thanks,<br>Observe Automation</p>
    `
  },
  7: {
    subject: `Follow-up: Invoice ${invoice.invoiceNumber} now 7 days overdue`,
    body: `
      <p>Hi ${invoice.clientName},</p>
      <p>We're following up on invoice ${invoice.invoiceNumber} for ${formattedAmount},
      which was due on ${formattedDueDate} and is now 7 days overdue.</p>
      <p>Could you let us know when we can expect payment, or get in touch
      if there's anything you need from us?</p>
      <p>Thanks,<br>Observe Automation</p>
    `
  },
  14: {
    subject: `Invoice ${invoice.invoiceNumber} — payment now 14 days overdue`,
    body: `
      <p>Hi ${invoice.clientName},</p>
      <p>Invoice ${invoice.invoiceNumber} for ${formattedAmount} is now 14 days overdue
      (original due date: ${formattedDueDate}).</p>
      <p>Please arrange payment at your earliest convenience, or contact us
      if there is an issue we should be aware of.</p>
      <p>Regards,<br>Observe Automation</p>
    `
  },
  30: {
    subject: `Final notice — Invoice ${invoice.invoiceNumber}`,
    body: `
      <p>Hi ${invoice.clientName},</p>
      <p>This is a final notice regarding invoice ${invoice.invoiceNumber}
      for ${formattedAmount}, which is now 30 days overdue.</p>
      <p>Please contact us within 5 working days to arrange payment
      or discuss the outstanding balance.</p>
      <p>Regards,<br>Observe Automation</p>
    `
  }
};

const template = templates[invoice.stage];

return [{
  json: {
    ...invoice,
    emailSubject: template.subject,
    emailBody:    template.body,
  }
}];
```

---

### Node 8: Send Email
- Type: **Gmail**
- To: `{{ $json.clientEmail }}`
- Subject: `{{ $json.emailSubject }}`
- Message: `{{ $json.emailBody }}` (HTML)

---

### Node 9: Append to Reminder Log
- Type: **Google Sheets — Append**
- Document: Invoice Reminder Log
- Sheet: Sheet1
- Map columns:
  - Invoice ID → `{{ $json.invoiceId }}`
  - Invoice Number → `{{ $json.invoiceNumber }}`
  - Client Name → `{{ $json.clientName }}`
  - Amount → `{{ $json.amount }}`
  - Due Date → `{{ $json.dueDate }}`
  - Stage → `{{ $json.stage }}`
  - Sent At → `{{ $now.toISO() }}`

---

## Testing approach

Before running the full workflow:
1. Manually test the Invoice Ninja API call in n8n using the HTTP Request node
2. Verify the response shape matches what the Filter Overdue code node expects
3. Run with the test invoice (past due date, status = Sent) to confirm all nodes fire correctly
4. Check the reminder log sheet to confirm the row was appended
5. Check Gmail to confirm the email arrived

---

## Next steps after this workflow is working

- Write portfolio article for observeautomation.com
- Build the appointment reminder workflow (Cal.com + n8n)
