---
date: "2026-05-27"
title: "SOCIAL DRAFT — LinkedIn: observability rebuild progress 2 (the metrics layer)"
description: "LinkedIn progress post for hiring managers and recruiters in the observability space. Covers the second pair of implementation posts (Grafana on top of InfluxDB, then Prometheus as a second metric store), framed around temporal judgment: what to invest in up front and what to defer."
categories: ["Social"]
tags: ["Social", "LinkedIn", "Draft"]
draft: true
---

Two more posts of the observability rebuild are now live, taking the implementation series to four components. The pattern from the first pair is compounding into the second, and the judgment calls are starting to show up where they matter most: in what gets deferred, not just what gets built.

What that looks like at this stage:

→ Two answers can be more right than one. The third post adds a second metrics store alongside the first one rather than flattening to a single store. Push-based for things that emit natively, pull-based for everything cloud-native. The bridge to flatten them would cost more in glue code, forever, than two stores ever cost in cognitive overhead. The senior call is to live with the apparent duplication because the alternative is worse.

→ Config-as-code where the cost is low, not where it's fashionable. Both datasources are declared in YAML in the repo, locked from UI edits, reproducible from a clean disk. Dashboards aren't declared the same way yet, deliberately, because their shape is still moving and locking that in early would slow every iteration. Knowing which to lock down when is half the job.

→ Build the on-ramp before the traffic. The pull-based scraper uses file-based service discovery from the first commit, even though only two targets exist. Adding the next host becomes "drop a JSON file" rather than "edit the scrape config and restart." That's what stops a platform needing a rework the day it gets popular.

Senior platform work is as much about what you deliberately defer as what you build. If you usually ask candidates about systems they shipped, try also asking: "what design decision did you deliberately defer, what told you it was the right call to defer, and what would change your mind?" Knowing when not to build is rarer than knowing when to build, and far harder to fake.

Links in the comments.

#Observability #SRE #PlatformEngineering #Hiring #EngineeringLeadership

---

*Note: LinkedIn posts with links in the body get less reach. Add the URLs as the first comment after posting.*

**Comment text:**
Series introduction (the higher-level argument): https://www.observeautomation.com/blog/rebuilding-observability-stack/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-blog-progress-2
Implementation series overview: https://www.observeautomation.com/homelab/monitoring-refresh-introduction/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-intro-progress-2
Post 3, Grafana on top of InfluxDB: https://www.observeautomation.com/homelab/grafana-for-proxmox/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-grafana
Post 4, Prometheus as a second metric store: https://www.observeautomation.com/homelab/prometheus-second-metric-store/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-prometheus

---

**Notes:**
- Word count: ~310 (slightly above the 225–300 target; the three-bullet structure with a substantive hiring takeaway is the right shape and trimming further weakens the close)
- Audience: hiring managers and recruiters in the observability/SRE/platform space (same as progress-1)
- Hook bridges from progress-1 ("Two more posts...taking the series to four components"), so a returning reader picks up the thread and a new reader can self-orient via the links
- Hashtags: same five as progress-1. Rationale in [[feedback-linkedin-audience-calibration]].
- Tech terms (Grafana, InfluxDB, Prometheus) appear only in linked post titles, not in the post body. "Push-based" and "pull-based" appear in body but are accessible enough for a technical hiring audience.
- Through-line is temporal judgment: what to invest in up front (datasources as code, file-SD), what to defer (dashboards as code), what to accept as permanent (two stores instead of one). Different from progress-1's through-line (scope discipline), so two posts in a row don't repeat the same hiring lesson.
- **Image:** post as a single-image post using `content/homelab/Grafana-For-Proxmox/images/06-grafana-proxmox-dashboard-trimmed.webp` (the trimmed Proxmox dashboard). Visually compelling to a non-practitioner — looks like the output of a real ops team — and varies the imagery from progress-1, which used the architecture diagram. Carousel format skipped for the same reasons as progress-1.
- Post Tue–Thu, 8–10am or 12–1pm
- **Sequencing:** Suggested gap of ~7 days after `linkedin-version-progress-1.md` so the feed doesn't get back-to-back posts on the same topic. Progress-1 covers posts 1–2 of the homelab series; this covers posts 3–4. The cadence pairs naturally with David's roughly weekly publishing rhythm.
