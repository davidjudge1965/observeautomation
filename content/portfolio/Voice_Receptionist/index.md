---
date: '2026-01-02'
draft: true
title: 'Voice Receptionist'
description: "Answer your calls when you're out"
categories: ["Portfolio"]
tags: ["n8n", "automation", "voice", "AI"]
layout: "single"
image: "/image/AI_Voice_Receptionist.png"
---
Can't get away from something when a call comes through?  Are your risking losing customers?

Maybe all they wanted was your opening hours or even just to book an appointment.

<!--more-->

Today, being tied to answering every call is no longer necessary.  An AI Receptionist can:
* Answer calls
* Handle queries based on your company's information
  * Opening hours,
  * Standard delivery terms,
  * etc.
* Book appointments
* And much more
* And, of course, hand-off the call to a real person 
  * if requested or 
  * if the AI doesn't have the answer

## This time the customer is me - my [ObserveAutomation](https://www.observeautomation.com) business

What should my receptionist do?
>I need the AI to answer questions with replies sourced from my company manual and frequently asked questions.

>It should be able to provide information on the services I offer.

>Recommend my [company's website](https://www.observeautomation.com) as the place to see my portfolio.

>It should let the user leave me a message and send it to me (GMail or WhatsApp)

>Last but not least, allow them to book a meeting

And it should do this while sounding a bit like me - I mean us my way of talking (tone, etc.).  While it is possible to train an AI to actually sound like me, that's not what I'm trying to do here and I think it might confuse customers.  


At a very high level, this is what it looks like:

![alt text](assets/High-Level_Workflow_Excalidraw.png)

The core of the system handling the call is called VAPI and it is what talks to the customer.  It has some information but mostly has instructions on how to answer in generic terms (for example: don't ask the same question twice).

VAPI is configured with some tools that it may call upon.  These are configured in the automation platform and may be simple workflows or complex AI flows.




 