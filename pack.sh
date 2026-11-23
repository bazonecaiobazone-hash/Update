#!/bin/bash
set -e

[ "$(id -u)" -eq 0 ] || { echo "Rode como root"; exit 1; }

export DEBIAN_FRONTEND=noninteractive

# Essenciais para o sistema funcionar bem
BASE="sudo curl wget git nano xz-utils unzip zip \
network-manager wpasupplicant \
pciutils usbutils htop ca-certificates"

# Firmware (Wi-Fi, placa de vídeo, etc). Precisa do repo non-free-firmware.
# Se a base é deblobbed de propósito, deixe vazio: FIRMWARE=""
FIRMWARE="firmware-linux firmware-misc-nonfree firmware-iwlwifi firmware-realtek"

apt update
apt install -y --no-install-recommends $BASE $FIRMWARE

# Limpa para a ISO não crescer à toa
apt clean
rm -rf /var/lib/apt/lists/*

echo "Pacotes instalados."
