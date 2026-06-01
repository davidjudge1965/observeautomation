---
date: "2026-05-26"
title: "SOCIAL DRAFT — LinkedIn: observability rebuild progress (ingress + first metrics)"
description: "LinkedIn progress post for the practitioner audience covering the first two implementation steps of the observability rebuild: Traefik ingress on a fresh VM, then InfluxDB with Proxmox as the first push-based source."
categories: ["Social"]
tags: ["Social", "LinkedIn", "Draft"]
draft: true
---

Two components of the observability rebuild are now running on the new monitor VM, and the design pattern is starting to assert itself.

The order was deliberate: ingress first, before any workload. Traefik stood up on a fresh Ubuntu VM, pointed at Cloudflare to get TLS certificates (for the s in https), and every later component drops into the same shape. Container with Traefik labels, CNAME in Bind (for DNS), HTTPS automatically, no host port published. That is the pattern for the next ten posts.

Then InfluxDB as the first metrics store, because Proxmox writes there natively. No exporter, no Telegraf, no glue. A scoped write-only token, a ten-second push interval, and the whole hypervisor's metrics are in the bucket within a minute.

Three small choices already paying for themselves:

→ Two Docker networks, "proxy" for ingress and "monitoring" for component-to-component traffic. Adding a new service is a one-line label change.
→ Bind-mounted folders rather than named volumes to make backups easier.
→ A write-only token for Proxmox. If it leaks, the blast radius is one bucket, not the whole instance.

Next up: Grafana on top of InfluxDB, then Prometheus for everything Proxmox doesn't already cover.

The carousel walks through it: target architecture, ingress running empty, the first router appearing green with TLS, the cert landing cleanly, and Proxmox's load average ticking into the bucket.

Links in the comments.

#Homelab #Observability #Docker #SRE #PlatformEngineering

---

*Note: LinkedIn posts with links in the body get less reach. Add the URLs as the first comment after posting.*

**Comment text:**
Series introduction: https://www.observeautomation.com/homelab/monitoring-refresh-introduction/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-intro
Post 1, monitor VM and Traefik: https://www.observeautomation.com/homelab/rebuild-01-monitor-vm-and-traefik/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-traefik
Post 2, InfluxDB for Proxmox metrics: https://www.observeautomation.com/homelab/rebuild-02-influxdb-and-proxmox/?utm_source=linkedin&utm_medium=social&utm_campaign=rebuilding-observability-stack&utm_content=comment-homelab-influxdb

---

**Carousel (5 slides, in order):**

1. `content/homelab/Monitoring-Refresh-Introduction/images/Monitoring_Architecture_Mermaid_Diagram.png`
   Caption: "The target architecture. Eleven posts to get here, one component at a time."
2. `content/homelab/Monitor-VM-And-Traefik/images/01-traefik-dashboard-first-boot.webp`
   Caption: "Step 1: ingress on the new monitor VM. Five entrypoints registered, both providers connected, zero user workloads. Foundation laid, nothing to route yet."
3. `content/homelab/InfluxDB-And-Proxmox/images/01-traefik-dashboard-influxdb-router.webp`
   Caption: "Step 2 lands: first workload behind ingress. influxdb@docker green-checked, TLS active, bound to the websecure entrypoint. The pattern works."
4. `content/homelab/InfluxDB-And-Proxmox/images/02-influxdb-initial-login.webp`
   Caption: "Real Let's Encrypt cert via the Cloudflare DNS-01 challenge. No port 80 exposed to the internet, and the browser treats the site as fully secure."
5. `content/homelab/InfluxDB-And-Proxmox/images/03-influxdb-data-explorer-proxmox-arriving.webp`
   Caption: "Proxmox's 15-minute load average, end-to-end: hypervisor → Traefik → InfluxDB → Data Explorer, with a fresh point every ten seconds."

Drop slide 4 if a 4-slide deck is preferred; the story still holds without the sign-in screen.

---

**Notes:**
- Word count: ~265 (within 225–280 sweet spot)
- Audience: practitioner peers (homelabbers, SREs, platform engineers); also signals execution discipline to the recruiter/hiring-manager audience reached by the first LinkedIn post
- Hook leads with a concrete progress claim, then immediately pivots to the design intent rather than tool-name-dropping
- No bridge intro to the previous two posts; this stands alone as an implementation update
- Post Tue–Thu, 8–10am or 12–1pm
- **Sequencing:** Suggested gap of ~7 days after `linkedin-version-business.md` so the feed doesn't get three posts on the same topic in quick succession
- **Carousel format:** LinkedIn renders document uploads (PDF) as native carousels. Export the five images into a single landscape PDF (1920×1080 or 1200×1500 portrait both work), with the caption rendered on each slide rather than relying on LinkedIn's image alt-text
