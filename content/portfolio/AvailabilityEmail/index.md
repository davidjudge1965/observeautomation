---
date: '2025-12-17'
draft: false
title: 'Availability Scanner'
description: "Automated email with my availability"
categories: ["Portfolio"]
tags: ["n8n", "automation", "availability"]
layout: "single"
image: "/image/Calendar_for_Availability.jpg"
---
Finding slots for a meeting can, depending on the week, be challenging.

This workflow pulls calendar entries from Google Calendar and determines what slots are available.
<!--more-->
While this could be written as a simple workflow, it would need some code to work and I'm always striving to write no- or no-code, so the automation is agentic (i.e. autonomous).

At a high-level, this is the workflow:<br>
![Alt](assets/AvailabilityFlowExcalidraw.jpg)

The workflow runs automatically at 8am every morning.  It starts by settting the parameters of the search fro availability - i.e. next 5 days, leave 30 minutes between events.

I use AI to find my availability while leaving me the 30 minutes buffer before and after existing meetings.

The last stage is to send me an email with the availability.  Just in case I know my diary has changed a fair bit, I include in the email a link to trigger the workflow manually.

While this automation does not save much time - probably only 3-4 minutes per time I need to find a slot, the fact it runs automatically every day at 8am means I don't have to go look for the information and the risk of picking an incorrect slot (or a typo) is greatly reduced.

For the more technically-minded, here's the flow from n8n:<br>
![alt text](assets/AvailabilityFlowN8N.jpg)

## What does it cost?
The n8n server is running on my own homelab, so other than electricity, there's no direct cost for automation.

The analysis of the job role is done by an LLM in the cloud: OpenAI ChatGPT 4.1-mini (via APIs) which is fast and cheap.  request processed costs less than £0.01.