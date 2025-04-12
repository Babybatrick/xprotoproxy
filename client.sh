#!/usr/bin/env bash

source .env

#Creating client URI
cat > ./proxy/hysteria/client <<EOL
hysteria2://$PASSWORD@$DOMAIN:443?sni=$DOMAIN&obfs=salamander&obfs-password=$OBFPASSWORD
EOL

cat > ./proxy/shadowsocks/client <<EOL
ss://$(echo -n chacha20-ietf-poly1305:$PASSWORD | base64 -w 0)@$DOMAIN:443?&tfo=1
EOL

cat > ./proxy/juicity/client <<EOL
juicity://$UUID:$PASSWORD@$DOMAIN:443?sni=$DOMAIN&congestion_control=bbr
EOL

cat > ./proxy/trojan/client <<EOL
trojan://$PASSWORD@$DOMAIN:$port_trojan?peer=$DOMAIN&alpn=h2
EOL

cat > ./proxy/brook/client <<EOL
brook://wssserver?wssserver=wss://$DOMAIN:443?/ws&param=%7B%22Host%22:%22$DOMAIN%22%7D&password=$PASSWORD
EOL

cat > ./proxy/socks5/client <<EOL
socks://$(echo -n $UUID:$PASSWORD@$DOMAIN:443 | base64 -w 0)
EOL

cat > ./proxy/snell/client <<EOL
snell://$(echo -n "chacha20-ietf-poly1305:$PASSWORD" | base64 -w 0)@$DOMAIN:443?plugin=obfs-local;obfs=tls;obfs-host=%7B%22Host%22:%22www.baidu.com%22%7D;obfs-uri=/&tfo=1
EOL

cat > ./proxy/tuic/client <<EOL
tuic://$UUID:$PASSWORD@$DOMAIN:443?sni=$DOMAIN&congestion_control=bbr&alpn=h3&upd_relay_mode=native
EOL