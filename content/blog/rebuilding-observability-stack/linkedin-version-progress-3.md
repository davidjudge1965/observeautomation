---
date: "2026-05-30"
title: "SOCIAL DRAFT — LinkedIn: observability rebuild progress 3 (central logging across the estate)"
description: "LinkedIn progress post for hiring managers and recruiters in the observability space. Covers the third trio of implementation posts (Loki + Alloy, then rolling Alloy across non-Docker and Docker hosts), framed around the diagnostic gap between surface signal and actual behaviour."
categories: ["Social"]
tags: ["Social", "LinkedIn", "Draft"]
ShowCodeCopyButtons: true
draft: true
---

Two of the three latest rebuild posts open with a moment where everything looked fine and nothing was actually working. Recognising that pattern early, before the surface signal earns your trust, is one of the more reliable seniority markers in platform engineering.

Three more posts of the rebuild are live, covering centralised logging and the roll-out of the log shipper across the rest of the estate. Two of them turn on exactly that gap.

→ The silent traversal trap. A non-root agent is meant to tail logs on a host it doesn't own. Systemd reports active, the journal is clean, the agent reports zero targets. The failure mode is an absence, not an error. The senior validation is the boring one: read the file as the agent's own user before declaring the deployment done. If a human can do it as that user, the agent can.

→ The retry-storm masquerading as health. New logs land, dashboards populate, surface signals all green. The agent's own log is meanwhile generating HTTP 400s on every push because a long-running container is handing back a year of buffered lines that the centre is correctly rejecting. The senior tell is reading the agent's own logs after the dashboards turn on, not just before.

→ Designing for the second instance from inside the first. The reason both diagnoses landed cheaply is the architecture was built for a second deployment from day one: parameterised configs, the same agent across Docker and systemd hosts, satellite-first testing before the planned roll-out. The senior move isn't "make it work on host one." It's "make the deployment on hosts two through ten cost the same, and surface the same signals."

Ask a candidate about a time something looked like it was working but wasn't, and how they noticed. The strong answers describe validation as a habit rather than a one-off; they run the explicit check before they need to.

Links in the comments.

#Observability #SRE #PlatformEngineering #Hiring #EngineeringLeadership

---

*Note: LinkedIn posts with links in the body get less reach. Add the URLs as the first comment after posting.*

**Comment text:**
Series introduction (the higher-level argument): https://www.observeautomation.com/blog/rebuilding-observability-stack/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-blog-progress-3

Implementation series overview: https://www.observeautomation.com/homelab/monitoring-refresh-introduction/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-intro-progress-3

Post 5, Loki and Alloy: https://www.observeautomation.com/homelab/rebuild-05-loki-and-alloy/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-loki

Post 6, Rolling Alloy to a non-Docker host: https://www.observeautomation.com/homelab/rebuild-06-rolling-alloy-to-a-non-docker-host/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-alloy-runner

Post 7, Alloy across the Docker estate: https://www.observeautomation.com/homelab/rebuild-07-alloy-across-the-docker-estate/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-alloy-docker

---

**Notes:**
- Word count: ~305 (matches progress-2; over the 225–280 ideal but the trio of bullets plus the substantive interview-question close is the right shape and trimming would weaken the takeaway)
- Audience: hiring managers and recruiters in the observability/SRE/platform space (same as progress-1, progress-2). See [[feedback-linkedin-audience-calibration]].
- Hook angle: the gap between surface signal and actual behaviour. Fresh frame, not covered in progress-1 (scope discipline) or progress-2 (temporal judgment). Three distinct hiring lessons in three posts means returning readers get a different takeaway each time rather than the same point repackaged.
- Hashtags: same five as progress-1 and progress-2.
- Tech terms (Loki, Alloy, Docker, systemd) appear only in linked post titles, not in the body. "Non-root agent", "systemd reports active", and "HTTP 400s" all stay because they're the specifics that make the diagnostic stories land — a hiring audience for SRE/platform roles can carry that load.
- **Image:** post as a single-image post using `content/homelab/Rebuild-07-Alloy-Across-The-Docker-Estate/images/04-loki-traefik-by-host-rate.webp` — three coloured lines showing per-host log rate. Visually proves "the architecture works across the estate" in one glance, which is the through-line of all three posts. Alternative: `content/homelab/Rebuild-05-Loki-And-Alloy/images/04-grafana-explore-loki-by-host.webp` (log volume + interleaved lines from monitor's containers) if you'd rather lead with the centralised-logging story.
- Comment URL block uses blank-line separation between entries per [[linkedin-post-requirements]]
- Post Tue–Thu, 8–10am or 12–1pm
- **Sequencing:** Suggested gap of ~7 days after `linkedin-version-progress-2.md`. Progress-1 covers homelab posts 1–2, progress-2 covers 3–4, this covers 5–7. The wider grouping reflects that posts 6 and 7 are tightly coupled to post 5 (same agent, same Loki, same architectural argument) — a 2-post grouping would have split that arc artificially.
