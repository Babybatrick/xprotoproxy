#!/usr/bin/env bash

source .env

cat > ./proxy/shadowsocks/client <<EOF
ss://$(echo -n chacha20-ietf-poly1305:$PASSWORD | base64 -w 0)@$DOMAIN:453?&tfo=1
EOF