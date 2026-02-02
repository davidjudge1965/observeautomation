# sudo systemctl edit docker

After 1st lot of comments, insert:
```
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --config-file /etc/docker/daemon.json --containerd=/run/containerd/containerd.sock

```