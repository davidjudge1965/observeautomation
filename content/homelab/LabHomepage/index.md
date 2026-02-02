---
date: '2026-01-13'
title: 'Implementing a Homepage'
description: "Creating a home page to access my homelab services and configurators."
categories: ["Homelabbing"]
tags: ["Homelab", "Homepage"]
layout: "single"
image: "/image/AI_Voice_Receptionist.webp"
draft: true
---
# Creating a homepage for my homelab

Often I struggle to remember the correct URL for the services on my home lab.  How to solve this?

Enter "Homepage" - yes, that's what it's called.

<!--more-->

Source youtube video: https://www.youtube.com/watch?v=mC3tjysJ01E

Get homepage from here: https://gethomepage.dev/

Docker installation documentation: https://gethomepage.dev/installation/docker/

The pattern I follow for installing new container is:
1. Create a DNS entry
2. Create a base compose file
3. Enrich the yaml file to work with Traefik

## Create the DNS entry
On my DNS server, I modified the zone file to include homepage@
``` bind
ntfy                    IN      CNAME   docker04.lab.davidmjudge.me.uk.
homepage                IN      CNAME   docker04.lab.davidmjudge.me.uk.
```


