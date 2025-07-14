#!/bin/sh
set -e

if [ -z "$WG_TOKEN" ]; then
    echo "ERROR: WG_TOKEN is not set."
    exit 1
fi

WG_URL="https://ipv64.net?wgconfig=${WG_TOKEN}"
echo "[INFO] Downloading WireGuard configuration from: $WG_URL"

mkdir -p /etc/wireguard
curl -fsSL "$WG_URL" -o /etc/wireguard/wg0.conf

echo "[INFO] Starting WireGuard interface wg0..."
wg-quick up wg0

# Halte den Container am Leben
tail -f /dev/null
