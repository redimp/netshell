#!/bin/sh

cat /etc/motd

echo "$(date) \$@: $@" >> /tmp/.entrypoint

exec "$@"
