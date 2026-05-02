---
date: '2026-05-02'
title: 'Vibe coding is great. Just not for your business.'
description: "Vibe coding is fast, fun, and produces impressive demos. Here's why I don't use it for client automations."
categories: ["Blog"]
tags: ["Automation", "Small Business", "n8n", "AI"]
image: "/image/Hero-why-i-dont-vibe-code.png"
hero_position: "center center"
draft: false
---

Vibe coding is everywhere right now. You describe what you want, an AI writes the code, you check it works, you ship it. Fast, impressive, and honestly quite fun.

I do it myself. My homelab is full of scripts I prompted into existence and half-understand. I use it to test ideas, prototype things, and build tools I only need to work once. For that kind of work, vibe coding is exactly right.

But I do not vibe code for clients. Here is why.

## A black box that nobody owns

When you vibe code something, you get something that works. What you do not always get is something anyone can explain. The logic is there, somewhere, but it was generated rather than designed. The person who built it may not fully understand why it works. And when it stops working, because something changes, because an API updates, because your business grows, nobody knows where to start.

For a personal project, that is fine. You tinker, you fix it, or you prompt your way to a new version.

For a small business, that is a problem for future you.

## Your business will change

Automation is not a one-time event. The process you automate today will evolve. A new supplier. An update to the LLM you are using. A change in how you invoice. A different email address. A team member who needs to be included. Small changes, but changes that need to be reflected in the automation or it stops being useful.

If the automation is a black box, every one of those changes requires the person who built it to come back and fix it. That is a cost, and a dependency, and it puts you in a worse position than before you automated anything.

That is not what I want for the people I work with.

## Built to be understood

I build on n8n, which helps. n8n workflows are visual. Each step is a labelled node. The logic flows left to right. WA non-technical person, with a bit of guidance, can look at a workflow and understand what it does. Not how to rebuild it from scratch, but enough to follow it, enough to spot when something looks wrong, and enough to ask the right questions.

I document what I build. I walk clients through it. And I design for the day when I am not involved any more.

That does not mean every client ends up running their own automations independently. Most do not want to. But they could, and that matters. It means the thing I hand over is an asset they own, not a dependency they are stuck with.

## The honest version

Vibe coding produces impressive demos. It is fast, cheap, and for the right use case it is genuinely brilliant.

But impressive demos are not what a small business needs. What a small business needs is something that works on a Tuesday morning six months from now, when something small has changed and nobody can remember why anything is set up the way it is.

That is what I build.
