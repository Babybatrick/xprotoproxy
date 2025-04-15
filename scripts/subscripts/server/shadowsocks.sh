#!/usr/bin/env bash

source .env

cat > ./proxy/shadowsocks/config.json <<EOF
{ 
  "server":"0.0.0.0", 
  "server_port":443, 
  "local_port":1080, 
  "password":"$PASSWORD", 
  "method":"chacha20-ietf-poly1305" 
}
EOF