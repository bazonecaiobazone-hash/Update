#!/bin/bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

[ "$(id -u)" -eq 0 ] || { echo "Rode como root"; exit 1; }

for f in ext.sh ext.service; do
    [ -f "$DIR/$f" ] || { echo "Faltando: $f"; exit 1; }
done

# data é opcional
if [ -f "$DIR/data.tar.gz" ]; then
    install -Dm644 "$DIR/data.tar.gz" /opt/data.tar.gz
else
    echo "Aviso: data.tar.gz não encontrado, pulando."
fi

install -Dm755 "$DIR/ext.sh"      /usr/local/bin/ext.sh
install -Dm644 "$DIR/ext.service" /etc/systemd/system/ext.service

if ! systemctl enable ext.service 2>/dev/null; then
    mkdir -p /etc/systemd/system/multi-user.target.wants
    ln -sf /etc/systemd/system/ext.service \
           /etc/systemd/system/multi-user.target.wants/ext.service
fi

echo "Instalado."
