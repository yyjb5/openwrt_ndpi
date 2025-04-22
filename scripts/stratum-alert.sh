#!/bin/sh

LOG_FILE="/tmp/stratum_detected.log"
ALERTED_IPS="/tmp/stratum_alerted_ips.txt"

[ -f "$ALERTED_IPS" ] || touch "$ALERTED_IPS"

ndpiReader -i br-lan -v 2 | while read -r line; do
  echo "$line" | grep -i "stratum" | while read -r match; do
    SRC_IP=$(echo "$match" | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -n1)
    if ! grep -q "$SRC_IP" "$ALERTED_IPS"; then
      echo "[!] Stratum detected from $SRC_IP at $(date)" | tee -a "$LOG_FILE"
      echo "$SRC_IP" >> "$ALERTED_IPS"

      # 可选：封锁 IP
      # iptables -I FORWARD -s "$SRC_IP" -j DROP

      # 可选：推送到微信/企业微信/Server酱
    fi
  done
done
