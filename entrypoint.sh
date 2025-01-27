#!/bin/sh

env | grep KUBERNETES &>/dev/null && sleep 0.5
cat /etc/motd >&2

exec "$@"
