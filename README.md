# netshell - docker and kubernetes toolkit container

```
           _      _        _ _
  _ _  ___| |_ __| |_  ___| | |
 | ' \/ -_)  _(_-< ' \/ -_) | |
 |_||_\___|\__/__/_||_\___|_|_|

```

## Features

`netshell` is a container that bundles the tools necessary for quickly
debugging services in your containerized environment.

## netshell with docker

Start a one-shot pod that is removed after it exists.
```bash
docker run -it --rm redimp/netshell
```
Attach to the network of a running container
```bash
docker run -it --rm --net container:<container_id> redimp/netshell
```
Attach to the hosts network
```bash
docker run -it --rm --net host redimp/netshell
```

## netshell with podman

Start a one-shot pod that is removed after it exists.
```bash
podman run -it --rm redimp/netshell
```
*Note: All docker examples work analog with podman.*

## netshell with kubernetes

Start a one-shot pod for debugging, removed after the shell exists.
```bash
kubectl run tmp-shell --rm -i --tty --image redimp/netshell
```

Attach an ephemeral container to an existing pod:
```bash
kubectl debug -it --image redimp/netshell pod
```

## Alternatives

- [netshoot](https://github.com/nicolaka/netshoot) a Docker + Kubernetes network
trouble-shooting swiss-army container. Highly recommended.
