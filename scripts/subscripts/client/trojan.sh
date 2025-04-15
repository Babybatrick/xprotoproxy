#!/usr/bin/env bash

source .env

cat > ./proxy/trojan/client <<EOF
trojan://$PASSWORD@$DOMAIN:463?peer=$DOMAIN&alpn=h2
EOF