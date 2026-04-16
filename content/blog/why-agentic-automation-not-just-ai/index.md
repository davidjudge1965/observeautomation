---
date: '2026-04-02'
title: 'Why I build automations rather than just use AI to do everything'
description: "Everyone is talking about using AI to build tools. Here is why I use an automation platform instead, and why that is better news for your business."
categories: ["Blog"]
tags: ["AI", "Automation", "n8n", "Small Business"]
image: "/image/BlogHeroPhoto.webp"
hero_position: "center center"
draft: false
---

A client said to me recently: "You could just ask AI to build you a tool, couldn't you?"

They had watched a video online. Someone typed a description of what they wanted, and a few seconds later there was a working application. No coding, no technical knowledge. It looked effortless.

It is a fair question. And the honest answer is: yes, sometimes you can. But for the kind of automation your business is going to depend on every day, there are better ways to build it. Here is why.

## What "vibe coding" actually is

The technique my client had seen has a name. Andrej Karpathy, one of the founders of OpenAI, coined the term "vibe coding" in early 2025. Collins Dictionary named it Word of the Year for 2025. It describes a way of building software by describing what you want in plain language and letting AI write the code.

It is real, and it is genuinely impressive. By last year, a quarter of companies in Y Combinator's startup programme had codebases where 95% of the code was AI-generated. Developers are using it to move faster, prototype ideas in hours instead of days, and build things that would previously have needed a team.

For a developer who knows what they are doing, it is a powerful accelerant. That is the honest case for it.

## The 70% problem

Here is where it gets complicated.

To be fair to vibe coding: the development process is genuinely iterative. You describe what you want, the AI builds it, you test it, spot a bug, describe the bug, the AI fixes it. Modern AI tools are quite good at this loop. Many people do reach a working product this way, sometimes remarkably quickly. That is not a myth.

The difficulty starts not during the build, but after. Making something reliable in production, handling unexpected errors gracefully, keeping it secure, and knowing what to do when something goes wrong at 9pm on a Tuesday, six months after it was built, by someone who has moved on: these are different challenges entirely.

Research published in late 2025 found that code co-authored by AI contained roughly 1.7 times more significant issues than code written by experienced developers.[^1] Separate analysis found that between 40% and 60% of AI-generated code contains security vulnerabilities.[^2] These are not findings about whether working software can be built with AI. It clearly can. They are findings about what that software tends to look like under the bonnet once it is running in the real world.

One widely-read assessment put it plainly: the final 30% of a software project, the part that makes it genuinely reliable, still requires real engineering knowledge.[^3] AI gets you to 70% very fast. The rest is the hard part, and it is the part that matters most once your business is depending on it.

## Why this matters for your business, not just developers

This might sound like a developer concern. It is not.

When you hire someone to build an automation for your business, you are not paying for code. You are paying for something that runs reliably for months without needing attention. A tool that breaks quietly is worse than no tool at all. If your email sorting automation silently fails, you think your inbox is under control when it isn't. If your call-handling workflow stops working on a bank holiday, you have no idea until a customer complains.

Custom code means custom maintenance. Every time an email provider changes how its API works, or a new edge case turns up that nobody anticipated, someone has to fix it. If that someone is the person who wrote the code, and they used AI to write code they do not fully understand, you have a fragile dependency on someone else's ability to manage a system they only half-know.

## Why I use n8n instead

n8n is a visual automation platform. Instead of code, each step in a workflow is a visible block: "watch for a new email", "send it to the AI", "read the response", "apply this label in Gmail". The blocks connect to each other with lines, left to right. You can see the whole thing laid out in front of you.

This matters more than it might sound. When I build something for a customer, I can show them exactly what it does. They can follow the logic themselves, without any technical background. I have had customers spot an edge case we had both missed, simply because they could see the flow clearly enough to think about it. That kind of transparency is simply not possible with code. You either trust the developer or you don't.

It also makes working together easier. When a customer wants to add a step, or change how something is handled, we can talk about it by pointing at something on screen rather than describing abstract logic. The conversation is grounded in something real.

When something goes wrong, n8n tells you exactly which step failed and why. There is an audit trail showing every automation run: what it received, what it decided, what it did. If your email sorter stops working, we do not need to speculate about where the problem is.

The connections to services like Gmail, Slack, or your CRM are also maintained by n8n's team. When Google changes something in its API, n8n updates the connector. That is not my problem, and it is not yours.

The AI component sits inside the workflow as one step among several. There are over 70 AI-specific nodes in n8n. The AI does the thinking; the platform handles the reliability and the visibility. That distinction matters a great deal.

## The honest case for AI code tools

I want to be clear that tools like Claude Code and Cursor are genuinely impressive, and I use them. For one-off integrations where no platform connector exists, for custom logic that is genuinely too complex for a visual tool, or for building a specific piece of infrastructure, AI-assisted development is often the right approach.

I used Claude Code to build the scaffolding for several of the automations in my portfolio. The difference is that I understand what I have built, I can maintain it, and I am accountable for it continuing to work.

For an SMB owner who wants something that runs and keeps running without needing to think about it again, that accountability matters. Vibe coding is a tool for people who know what they are doing with it. In the wrong hands, it produces something that looks finished but is not.

## What "agentic automation" actually means

The word "agentic" comes from "agency": the capacity to act independently and achieve outcomes. Merriam-Webster defines it as functioning like an agent, having the means and power to get things done.[^4] Applied to AI, it means a system designed to execute tasks on its own rather than waiting to be told what to do next.

The phrase "Agentic Automation" gets used a lot. Here is what it means in practice.

Traditional automation follows rules: if this email arrives, move it to that folder. This works until a supplier changes their subject line, or an email arrives that the rules did not anticipate. Then the automation fails silently and you are back where you started.

Agentic automation can think. The email arrives, the AI reads it, decides what kind of email it is based on the content rather than a keyword match, routes it to the right place, flags the urgent ones, and drafts a reply to the routine ones. It adapts to variations rather than breaking on them.

One description I keep coming back to: a conversation partner gives you answers. An agentic tool delivers outcomes. ChatGPT can tell you how to sort your inbox. An agentic automation actually sorts it.

## What this means for you

You do not need to understand any of this under the hood. That is rather the point.

What you need to know is that there is a difference between "AI built something quickly" and "AI built something you can rely on". The first is impressive to watch. The second is what your business actually needs.

If you want to see what this looks like in practice, the automations in my [portfolio](/portfolio/) are all built this way: visual, maintainable, and built to keep running without constant attention.

Or if you have a specific problem in mind, [get in touch](/contact/) for a no-cost, no-obligation conversation. No hard sell, just an honest look at whether automation could make a difference for your business.

---

[^1]: Analysis of 470 open-source GitHub pull requests, December 2025, reported in *The Evidence Against Vibe Coding: What Research Reveals About AI Code Quality*, Software Seni.

[^2]: *5 Vibe Coding Risks and Ways to Avoid Them in 2025*, Zencoder, citing aggregated security research across AI code generation tools.

[^3]: *The 70% problem: Hard truths about AI-assisted coding*, Addy Osmani, 2025.
[^4]: *Agentic*, Merriam-Webster, https://www.merriam-webster.com/slang/agentic
