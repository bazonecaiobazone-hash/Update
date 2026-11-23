#!/bin/bash
set -e

[ "$(id -u)" -eq 0 ] || { echo "Rode como root"; exit 1; }
export DEBIAN_FRONTEND=noninteractive

SRC=/etc/apt/sources.list.d/debian.sources

# Define os componentes do repo
if [ "$1" = "--firmware" ]; then
    COMP="main non-free-firmware"
else
    COMP="main"
fi

if [ -f "$SRC" ]; then
    sed -i "s/^Components: .*/Components: $COMP/" "$SRC"
elif [ -f /etc/apt/sources.list ]; then
    sed -i -E "s/(trixie[a-z-]* ).*/\1$COMP/" /etc/apt/sources.list
fi

apt update

# Pacotes base
apt install -y --no-install-recommends \
  sudo curl wget git nano ca-certificates xz-utils \
  network-manager pciutils usbutils

# Firmware (só com --firmware)
if [ "$1" = "--firmware" ]; then
    apt install -y --no-install-recommends \
      firmware-iwlwifi firmware-realtek
fi

# Limpa para a ISO não crescer
apt clean
rm -rf /var/lib/apt/lists/*

echo "Pacotes instalados."
