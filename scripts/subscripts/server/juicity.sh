#!/usr/bin/env bash

source .env

cat > ./proxy/juicity/config.json <<EOF
{
  "listen": ":443",
  "users": {
    "$UUID": "$PASSWORD"
  },
  "certificate": "$CERTPATH",
  "private_key": "$PKEYPATH",
  "congestion_control": "bbr",
  "log_level": "info"
}
EOF