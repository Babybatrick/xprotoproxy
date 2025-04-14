#!/usr/bin/env bash

source .env

#Creating client URI
cat > ./proxy/hysteria2/client <<EOL
hysteria2://$PASSWORD@0xhy.$DOMAIN:443?sni=0xhy.$DOMAIN&obfs=salamander&obfs-password=$OBFPASSWORD
EOL

cat > ./proxy/tuic/client <<EOL
tuic://$UUID:$PASSWORD@0xtc.$DOMAIN:433?sni=0xtc.$DOMAIN&congestion_control=bbr&alpn=h3&upd_relay_mode=native
EOL

cat > ./proxy/shadowsocks/client <<EOL
ss://$(echo -n chacha20-ietf-poly1305:$PASSWORD | base64 -w 0)@0xss.$DOMAIN:453?&tfo=1
EOL

cat > ./proxy/trojan/client <<EOL
trojan://$PASSWORD@0xtj.$DOMAIN:463?peer=0xtj.$DOMAIN&alpn=h2
EOL

cat > ./proxy/juicity/client <<EOL
juicity://$UUID:$PASSWORD@0xjc.$DOMAIN:473?sni=0xjc.$DOMAIN&congestion_control=bbr
EOL