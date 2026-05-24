---
date: "2026-05-24"
title: "SOCIAL DRAFT — LinkedIn: rebuilding observability stack"
description: "LinkedIn post positioning the observability rebuild for recruiters, TAs, and hiring managers."
categories: ["Social"]
tags: ["Social", "LinkedIn", "Draft"]
draft: true
---

Hiring an observability person? Everyone knows the tools. The real test is who can shave hours off your MTTR when production breaks at 2am.

That comes down to whether someone can walk into a system that has been bolted together over five years and see what is missing, what is over-engineered, and what to do next.

That is hard to test with a take-home exercise. So I have started writing down the closest proxy I can manage: rebuilding the observability stack on my own infrastructure, from scratch, with no manager telling me where to stop and no tech-debt excuses available.

A platform, properly designed, scaled down to fit a homelab. Separate stores for metrics, logs, and traces. Push-based ingest where components emit natively. Pull-based for everything else. One alerting surface, so noise can be tuned in one place.

Equally important is what I am deliberately not building. No Kubernetes. No multi-tenancy. No long-term retention strategy. Each of those is a scope decision, not an oversight. Large platforms end up unmanageable not because anyone added the wrong component, but because nobody told themselves "no" often enough.

The blog post explains the higher-level argument. The implementation series is live and growing. One component per post, with the actual configuration as it lands.

Link in the comments.

#Observability #PlatformEngineering #SRE #Hiring

---

*Note: LinkedIn posts with links in the body get less reach. Add the URL as the first comment after posting.*

**Comment text:**
Blog post: https://www.observeautomation.com/blog/rebuilding-observability-stack/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-blog
Implementation series: https://www.observeautomation.com/homelab/monitoring-refresh-introduction/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab

---

**Notes:**
- Word count: ~225 (within 150–400 target)
- Audience: recruiters, TAs, hiring managers
- Hook leads with a direct address to the hiring decision-maker
- Post Tue–Thu, 8–10am or 12–1pm
