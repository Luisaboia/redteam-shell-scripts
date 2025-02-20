#!/bin/bash
if [ -z "$1" ]; then
  echo "Uso: bash ping.sh <endereco_ip_do_alvo>"
  exit 1
fi

TARGET_IP="$1"

echo "Iniciando pings contínuos para $TARGET_IP (Ctrl+C para parar)..."

while true; do
  ping -c 1 $TARGET_IP > /dev/null 2>&1
done