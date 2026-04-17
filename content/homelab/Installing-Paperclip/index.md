---
date: '2026-04-03'
title: 'Installing Paperclip'
description: "To follow"
categories: ["Blog"]
tags: ["AI", "Automation", "n8n", "Small Business", "Paperclip"]
image: "/image/BlogHeroPhoto.webp"
hero_position: "center center"
draft: true
---

## I'm getting excited by Paperclip
... and the concept of a zero-employee company.  So I decided to set it up to experiment.

But first:

## What is Paperclip?
(Taken from their web site.)
Paperclip is the control plane for autonomous AI companies. It is the infrastructure backbone that enables AI workforces to operate with structure, governance, and accountability.

One instance of Paperclip can run multiple companies. Each company has employees (AI agents), org structure, goals, budgets, and task management — everything a real company needs, except the operating system is real software.

## How am I installing Paperclip?
I want to constrain Paperclip a little so I will install it in Docker on its own VM running Ubuntu 24.04.

Before I do anything else, I will update my dns for "docker05" and while I'm at it I will also add paperclip as a CNAME in my DNS.

On the VM, I will need to install docker.  I'll use the usual approach:

```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

apt-cache policy docker-ce

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl status docker
```


Of course I don't want to run my containers as root so I will give my user access to the docker command:
`sudo usermod -aG docker ${USER}`

I will create a directory `paperclip` in which to put my container and its data.  Within paperclip, I will create a `paperclip-data` directory for the data.  Paperclip uses postgres so I will also create a `postgres-data` directory

Initially I will set up paperclip without the traefik labels - a clean vanilla install.

The documentation site for paperclip doesn't seem to have a useful compose file to use, however the github (wow! 45k stars in around 4 weeks!) [has](https://github.com/paperclipai/paperclip/blob/master/docker/docker-compose.yml).

I don't like hardcoded values in compose files, so I asked Claude to:
```
Please adjust the file compose.yml which is in content/homelab/installing-paperclip to:
1: use a .env file
2: Remove the Volumes section
3: Reconfigure the volumes section for db and server to use local directories (paperclip-data and postgres-data)

Also create the appropriate .env file
Ensure the file is added to .gitignore
```