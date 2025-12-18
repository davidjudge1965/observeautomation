---
date: '2025-12-18'
title: 'Notifications with ntfy'
description: "Enabling notifications in my home lab and network."
categories: ["Homelabbing"]
tags: ["Homelab", "ntfy"]
layout: "single"
image: "/image/ntfy_banner.webp"
---

As part of my wider monitoring of my home lab, I want active notifications that I can receive while at home even when my broadband is down - in fact, mainly when my broadband is down.

Most of my methods of notification (Email, slack, etc.) require an internet connection. But I’ve been having minor outages due to either my ISP or my new router and I want to be notified of these while the outage is on-going.

Ntfy.sh is easy to deploy as a container, which is the approach I’ve taken (details lower in this article). It will sit behind traefik to act as a reverse proxy and to provide the certificates.

As always, the first step after deciding where the container is run is to update my DNS with a CNAME record:

``` dns
ntfy		IN	CNAME	docker04.lab.davidmjudge.me.uk.
```
After a quick docker compose restart of our dns container, the new name is resolvable.

``` bash
$ nslookup ntfy.lab.davidmjudge.me.uk
Server:  UnKnown
Address:  192.168.178.5

Name:    docker04.lab.davidmjudge.me.uk
Address:  192.168.178.54
Aliases:  ntfy.lab.davidmjudge.me.uk
```

TODO: Insert piece about whitelisting - https://blog.cthudson.com/2023-11-06-traefik-ipwhitelist/

TODO Do not let the container create the directories as they will be owned by root which causes problems

I initially spun up an instance of ntfy.sh using the docker compose section of the ntfy.sh documentation. I could connect to the web UI directly using its IP address and port, but had a message telling me that the messaging API required an SSL-encrypted connection. And, as there were no traefik labels in the compose file, the container wasn’t detected and wasn’t being proxied.

A quick update of the ntfy compose.yml fixed this and we now have a cert for ntfy: alt text

## Create a user
``` bash
david@docker04:~/ntfy/etc/ntfy$ docker exec -it ntfy /bin/sh
~ $ ntfy user add --role=admin david
user david added with role admin
~ $ ntfy user list
user david (role: admin, tier: none)
- read-write access to all topics (admin role)
user * (role: anonymous, tier: none)
- no topic-specific permissions
- no access to any (other) topics (server config)
~ $ exit
```


## Creating a token
Note that as this web site is built on a base that’s in GitHub, there are some rules I need to comply with - one is not to store tokens. So I have obfuscated the token in the next two commands or their output

``` bash
david@docker04:~/ntfy/etc/ntfy$ docker exec -it ntfy /bin/sh
~ $ ntfy token add david
token tk_XXXXXXXXXXXXXXXXXXXXXXXXXXXXX created for user david, never expires
~ $ exit
david@docker04:~/ntfy/etc/ntfy$ 
```


## Sending a message to ‘homelab’
``` bash 
david@docker04:~/ntfy/etc/ntfy$ curl -H "Title: ${HOSTNAME} -- ssh login" \
  -u :tk_XXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
  https://ntfy.lab.davidmjudge.me.uk/homelab \
  -d "This is a test message"
{"id":"QwMDCMvJjlqN","time":1766083567,"expires":1766126767,"event":"message","topic":"homelab","title":"docker04 -- ssh login","message":"This is a test message"}
david@docker04:~/ntfy/etc/ntfy$ 
```
Message appearing in the ntfy Web UI:
![Alt](assets/ntfy_after_2_alerts.jpg)





The documentation site for ntfy.sh is: https://docs.ntfy.sh/