#!/bin/sh
mkdir -p /mnt/data
tar -xzf /opt/data.tar.gz -C /mnt/data
chmod -R a+rwX /mnt/data
