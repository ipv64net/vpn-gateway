#!/usr/bin/env bash

set -e

SERVICE_BASE_URL="https://ipv64.net/"
WG_CONFIG_URL="${SERVICE_BASE_URL}?wgconfig=${WG_TOKEN}"
WG_STATS_URL="${SERVICE_BASE_URL}?wgstats=${WG_TOKEN}"

##

ACTION="${1}"

if [ "${ACTION}" == "configure" ]; then
  # configuration mode
  read -s -p "Token: " WG_TOKEN
  echo "${WG_TOKEN}"
elif [ "${ACTION}" == "run" ]; then
  # daemonize
  if [ -z "${WG_TOKEN}" ]; then
    TS=$(date +"%Y-%m-%d %H:%M:%S.%N %Z")
    echo "[ERROR] ${TS} | Missing WG_TOKEN"
    exit 1
  fi
else
  TS=$(date +"%Y-%m-%d %H:%M:%S.%N %Z")
  echo "[ERROR] ${TS} | Missing or invalid ACTION. 'configure' or 'run'"
  exit 1
fi

##

# create & enter working directory
mkdir -p /etc/wireguard
if ! cd /etc/wireguard; then
  TS=$(date +"%Y-%m-%d %H:%M:%S.%N %Z")
  echo "[ERROR] ${TS} | Could not create working directory"
  exit 1
fi

# download up to date configuration
TS=$(date +"%Y-%m-%d %H:%M:%S.%N %Z")
echo "[INFO] ${TS} | Downloading WireGuard configuration"
if ! curl -fsL "${WG_CONFIG_URL}" -o ./wg0.conf; then
  TS=$(date +"%Y-%m-%d %H:%M:%S.%N %Z")
  echo "[ERROR] ${TS} | Could not download new configuration"
  exit 1
fi

# connect wireguard tunnel
TS=$(date +"%Y-%m-%d %H:%M:%S.%N %Z")
echo "[INFO] ${TS} | Starting WireGuard interface wg0"
if ! wg-quick up wg0; then
  TS=$(date +"%Y-%m-%d %H:%M:%S.%N %Z")
  echo "[ERROR] ${TS} | Could not start WireGuard interface"
  exit 1
fi

if [ "${ACTION}" == "run" ]; then
  # keep container running
  while true; do
    TS=$(date +"%Y-%m-%d %H:%M:%S.%N %Z")
    RESPONSE=$(curl -fsL "${WG_STATS_URL}" | head -n 1)
    echo "[INFO] ${TS} | ${RESPONSE}"
    sleep 300
  done
fi
