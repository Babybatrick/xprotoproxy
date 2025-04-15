#!/usr/bin/env bash

source .env

cat > ./proxy/juicity/client <<EOF
juicity://$UUID:$PASSWORD@$DOMAIN:473?sni=$DOMAIN&congestion_control=bbr
EOF