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

Start a one-shot pod that is deleted after it exists.
```
docker run -it --rm redimp/netshell
```

## netshell with kubernetes

Start a one-shot pod for debugging, removed after the shell exists.
```
kubectl run tmp-shell --rm -i --tty --image redimp/netshell
```

## Alternatives

- [netshoot](https://github.com/nicolaka/netshoot) a Docker + Kubernetes network
trouble-shooting swiss-army container. Highly recommended.
