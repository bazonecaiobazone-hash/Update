#!/bin/sh
[ -f /opt/data.tar.gz ] || exit 0
mkdir -p /mnt/data
tar -xzf /opt/data.tar.gz -C /mnt/data
chmod -R a+rwX /mnt/data
