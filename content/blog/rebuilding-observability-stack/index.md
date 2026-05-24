---
date: "2026-05-24"
title: "Rebuilding my observability stack: what 'properly designed' actually means"
description: "A senior observability practitioner rebuilds his monitoring stack from scratch. Why the design matters more than the tools, what scope discipline looks like, and what to expect when hiring someone for this kind of work."
categories: ["Blog"]
tags: ["Blog", "Observability", "Engineering"]
image: "/image/MonitoringHomelabPhoto.webp"
hero_position: "center top"
draft: true
---

When you have spent enough years designing observability platforms, you develop strong opinions about what a properly designed one looks like. Strong enough that an ad-hoc monitoring setup makes you twitch.

Mine was making me twitch. More to the point, it wasn't telling me what I needed to know: three places to look when something broke, and none of them the right one. So I am rebuilding it.

<!--more-->

Over the next few months I am replacing the monitoring stack on my own infrastructure with something deliberately designed: a fresh VM, one component at a time, each landing as its own write-up. The full technical series lives in the [homelab section of this site](/homelab/monitoring-refresh-introduction/). This post is the higher-level argument, written for anyone trying to read the depth of an observability practitioner's experience from the outside.

## What "properly designed" looks like

Most monitoring setups grow. They start with something pragmatic, then expand without a plan. A vendor product because the company already had it. A dashboard because someone built it for a different problem. A scrape config because someone needed a metric in a hurry. The end result is functional, but it is rarely what anyone would design from a blank sheet.

What I want instead is a platform: the same shape I would build inside a small engineering team, scaled down to fit a homelab. Separate stores for metrics, logs, and traces, because their access patterns are different and pretending they aren't always ends in tears. Push-based ingest for the components that emit natively. Pull-based for everything else. A unified ingest layer for new instrumentation so the same plumbing decision is not made twice. Alerting routed through a single notification surface so noise can be tuned in one place.

The point of all this discipline is reducing time-to-resolution. When something breaks at 2am, the question is always the same: what changed, what failed, what is the blast radius. A properly designed platform answers those in seconds, not in twenty minutes of dashboard-hopping across three tools that don't talk to each other. Faster diagnosis, faster recovery. That is what observability is supposed to deliver, and what an ad-hoc setup quietly fails to do.

The specific tools matter less than the discipline of having a design at all. The series works through the actual choices in the homelab; I am using the open-source Grafana stack, but most of it could be substituted without changing the argument.

## Why I'm doing it step by step

Observability platforms rarely arrive end-to-end in one go. They grow in response to need, and the order in which components arrive shapes the design. So mine is going to grow the way I would grow one for a small team: tactical first, refactored toward strategic once the load justifies the complexity.

If every component arrived at once the write-up would be eight thousand words and useless to anyone reasoning about their own setup. One component per post. The decision record alongside the configuration as it lands. The kind of artefact I would have killed for when I was the new engineer trying to figure out what a senior person had been thinking.

## What I am deliberately not building

Discipline about what to leave out matters as much as discipline about what to include. So:

- **No Kubernetes.** Docker Compose is enough at this scale and keeps every write-up readable in a single file. The skills transfer; the complexity doesn't.
- **No multi-tenancy or RBAC.** One admin, one dashboard. Adding access control is a separate project.
- **No long-term retention strategy.** When the storage layer starts hurting on disk, I will add a long-term store or migrate. Future post.

Each of those is a scope decision, not an oversight. The reason large platforms end up unmanageable is rarely because anyone added the wrong component. It is because nobody told themselves no often enough.

## What this is supposed to signal

If you are hiring an observability practitioner, the question you are trying to answer is not "do they know the tools." Everyone knows the tools. The question is whether someone can walk into a system that has been bolted together over five years, see what is missing, see what is over-engineered, and make sensible decisions about what to do next. Because the difference between a strong observability hire and a weak one shows up in your MTTR.

That is hard to test with a take-home exercise. The closest proxy is watching how someone builds the same kind of system for themselves, with no manager telling them where to stop and no tech-debt excuses available.

So that is what I am writing down.

## Following along

The implementation series lives in the [homelab section](/homelab/monitoring-refresh-introduction/), one component per post, in roughly the order they need to arrive. If you are hiring for senior observability work, or evaluating someone who claims to be a senior observability person, the series is the long-form answer to "show me how you would design this from scratch."

[Get in touch](/contact/) if you would like to talk.
