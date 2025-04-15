#!/usr/bin/env bash

source .env

cat > ./proxy/hysteria2/client <<EOF
hysteria2://$PASSWORD@$DOMAIN:443?sni=$DOMAIN&obfs=salamander&obfs-password=$OBFPASSWORD
EOF