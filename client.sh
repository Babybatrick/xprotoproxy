#!/usr/bin/env bash

source .env

#Creating client URI
cat > ./proxy/hysteria2/client <<EOL
hysteria2://$PASSWORD@$DOMAIN:443?sni=$DOMAIN&obfs=salamander&obfs-password=$OBFPASSWORD
EOL

cat > ./proxy/tuic/client <<EOL
tuic://$UUID:$PASSWORD@$DOMAIN:433?sni=$DOMAIN&congestion_control=bbr&alpn=h3&upd_relay_mode=native
EOL

cat > ./proxy/shadowsocks/client <<EOL
ss://$(echo -n chacha20-ietf-poly1305:$PASSWORD | base64 -w 0)@$DOMAIN:453?&tfo=1
EOL

cat > ./proxy/trojan/client <<EOL
trojan://$PASSWORD@$DOMAIN:463?peer=$DOMAIN&alpn=h2
EOL

cat > ./proxy/juicity/client <<EOL
juicity://$UUID:$PASSWORD@$DOMAIN:473?sni=$DOMAIN&congestion_control=bbr
EOL