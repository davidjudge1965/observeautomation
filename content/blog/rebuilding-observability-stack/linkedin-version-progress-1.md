---
date: "2026-05-26"
title: "SOCIAL DRAFT — LinkedIn: observability rebuild progress 1 (foundations)"
description: "LinkedIn progress post for hiring managers and recruiters in the observability space. Covers the first two implementation steps of the observability rebuild, framed as visible evidence of senior design judgment."
categories: ["Social"]
tags: ["Social", "LinkedIn", "Draft"]
draft: true
---

A couple of weeks ago I posted about hiring for observability skill: the real test isn't whether someone knows the tools, it's whether they can walk into an unfamiliar system and make sensible calls about what to fix, what to leave, and what to leave out.

Hard to test with a take-home exercise. Easier to demonstrate live. The implementation series is now two posts in, and the pattern is already doing the work.

What "doing the work" looks like at this stage:

→ Foundation before features. The first post gets the ingress layer in before any monitoring component arrives. Every later component drops into the same shape, which is what makes the next ten posts boring rather than ad hoc.

→ Right architecture for the data, not the same architecture for everything. The second post wires up the first metrics source by pushing rather than pulling, because that's how it emits natively. Choosing to fit the source, not the other way round, is what stops a stack accumulating glue code.

→ Visible scope discipline. Each post calls out what was deliberately left out and why. Done well the first time, this is what stops a platform sprawling into something nobody can operate.

That's the kind of thinking I'd want to see in any senior observability hire's portfolio. If your usual proxy is "tell me about a hard incident," consider asking instead: "show me a system you designed, and the decisions you didn't include." It separates engineers from senior engineers more reliably than incident war stories do.

Links in the comments.

#Observability #SRE #PlatformEngineering #Hiring #EngineeringLeadership

---

*Note: LinkedIn posts with links in the body get less reach. Add the URLs as the first comment after posting.*

**Comment text:**
Series introduction (the higher-level argument): https://www.observeautomation.com/blog/rebuilding-observability-stack/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-blog-progress-1
Implementation series overview: https://www.observeautomation.com/homelab/monitoring-refresh-introduction/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-intro
Post 1, monitor VM and Traefik: https://www.observeautomation.com/homelab/monitor-vm-and-traefik/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-traefik
Post 2, InfluxDB for Proxmox metrics: https://www.observeautomation.com/homelab/influxdb-and-proxmox/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-influxdb

---

**Notes:**
- Word count: ~270 (within 225–300 sweet spot)
- Audience: hiring managers and recruiters in the observability/SRE/platform space. Skews technical-enough-to-evaluate, not technical-enough-to-implement.
- Hook bridges from the first LinkedIn post in the series ("a couple of weeks ago I posted about hiring..."), so this reads as a planned follow-up rather than a standalone update
- Hashtag rationale: dropped `#Homelab` (signals hobbyist), dropped `#Docker` (too low-level for hiring filters). Kept `#Observability`, `#SRE`, `#PlatformEngineering` as core role-area tags. Added `#Hiring` (recruiter-facing) and `#EngineeringLeadership` (hiring-manager-facing).
- Tech terms (Traefik, InfluxDB, Proxmox) appear only in linked post titles, not in the post body. Body stays in the language of design decisions rather than configuration mechanics.
- **Image:** post as a single-image post using `content/homelab/Monitoring-Refresh-Introduction/images/Monitoring_Architecture_Mermaid_Diagram.png` (the architecture diagram). It's the only one of the available screenshots that visually communicates "this person designs systems" to a non-practitioner. Carousel format deliberately skipped — the other captured screenshots (empty Traefik dashboard, populated Traefik dashboard, InfluxDB login, Data Explorer line chart) are visually inert to a non-practitioner and would pad rather than reinforce.
- Post Tue–Thu, 8–10am or 12–1pm
- **Sequencing:** Suggested gap of ~7 days after `linkedin-version-business.md` so the feed doesn't get three back-to-back posts on the same topic
