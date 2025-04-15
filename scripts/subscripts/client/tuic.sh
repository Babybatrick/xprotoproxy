#!/usr/bin/env bash

source .env

cat > ./proxy/tuic/client <<EOF
tuic://$UUID:$PASSWORD@$DOMAIN:433?sni=$DOMAIN&congestion_control=bbr&alpn=h3&upd_relay_mode=native
EOF