#!/usr/bin/env bash

source .env

#Creating client URI
cat > ./proxy/hysteria2/client <<EOL
hysteria2://$PASSWORD@0xhy.$DOMAIN:443?sni=0xhy.$DOMAIN&obfs=salamander&obfs-password=$OBFPASSWORD
EOL

cat > ./proxy/shadowsocks/client <<EOL
ss://$(echo -n chacha20-ietf-poly1305:$PASSWORD | base64 -w 0)@0xss.$DOMAIN:443?&tfo=1
EOL

cat > ./proxy/juicity/client <<EOL
juicity://$UUID:$PASSWORD@0xjc.$DOMAIN:443?sni=0xjc.$DOMAIN&congestion_control=bbr
EOL

cat > ./proxy/trojan/client <<EOL
trojan://$PASSWORD@0xtj.$DOMAIN:$port_trojan?peer=0xtj.$DOMAIN&alpn=h2
EOL

cat > ./proxy/brook/client <<EOL
brook://wssserver?wssserver=wss://0xbk.$DOMAIN:443?/ws&param=%7B%22Host%22:%220x.bk$DOMAIN%22%7D&password=$PASSWORD
EOL

cat > ./proxy/socks5/client <<EOL
socks://$(echo -n $UUID:$PASSWORD@0xs5.$DOMAIN:443 | base64 -w 0)
EOL

cat > ./proxy/snell/client <<EOL
snell://$(echo -n "chacha20-ietf-poly1305:$PASSWORD" | base64 -w 0)@0xsn.$DOMAIN:443?plugin=obfs-local;obfs=tls;obfs-host=%7B%22Host%22:%22www.baidu.com%22%7D;obfs-uri=/&tfo=1
EOL

cat > ./proxy/tuic/client <<EOL
tuic://$UUID:$PASSWORD@0xtc.$DOMAIN:443?sni=0xtc.$DOMAIN&congestion_control=bbr&alpn=h3&upd_relay_mode=native
EOL