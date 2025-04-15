#!/usr/bin/env bash

#DEFINING VARIABLES

read -p "Enter a domain name: " domain
[[ $domain =~ ^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$ ]] && echo "Proceeding" && echo "" || { echo "Invalid domain name, exiting..."; exit 1; }

echo ""

read -p "Enter an email address: " email
[[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]] && echo "Proceeding" && echo "" || { echo "Invalid email address, exiting..."; exit 1; }

certpath=/etc/letsencrypt/live/$domain/fullchain.pem
pkeypath=/etc/letsencrypt/live/$domain/privkey.pem
localcertpath=./ssl/fullchain.pem
localpkeypath=./ssl/privkey.pem

#REQUESTING CERTIFICATE
certbot certonly --standalone -d $domain --non-interactive --agree-tos --no-eff-email --email $email

cp $certpath $localcertpath
cp $pkeypath $localpkeypath

cat << EOF > xproto.conf
# -----------------------------
# Main user credentials
# -----------------------------

PASSWORD=$(openssl rand -base64 48 | tr '/+' 'xQ')
OBFPASSWORD=$(openssl rand -base64 48 | tr '/+' 'xQ')
UUID=$(uuidgen)


# -----------------------------
# Domain & Email
# -----------------------------

DOMAIN=${domain}
EMAIL=${email}


# -----------------------------
# Certificate data
# -----------------------------

CERTPATH=${certpath}
PKEYPATH=${pkeypath}
LOCALCERTPATH=${localcertpath}
LOCALPKEYPATH=${localpkeypath}
EOF

./config.sh

./client.sh

docker compose up -d
echo "XProto is ready to go!"

echo ""
echo ""
echo ""
echo "HYSTERIA2-----------HYSTERIA2"
qrencode -t UTF8 $(cat ./proxy/hysteria2/client)
echo $(cat ./proxy/hysteria2/client)
echo ""
echo ""
echo ""
echo "TUIC---------------------TUIC"
qrencode -t UTF8 $(cat ./proxy/tuic/client)
echo $(cat ./proxy/tuic/client)
echo ""
echo ""
echo ""
echo "SHADOWSOCKS-------SHADOWSOCKS"
qrencode -t UTF8 $(cat ./proxy/shadowsocks/client)
echo $(cat ./proxy/shadowsocks/client)
echo ""
echo ""
echo ""
echo "TROJAN-----------------TROJAN"
qrencode -t UTF8 $(cat ./proxy/trojan/client)
echo $(cat ./proxy/trojan/client)
echo ""
echo ""
echo ""
echo "JUICITY---------------JUICITY"
qrencode -t UTF8 $(cat ./proxy/juicity/client)
echo $(cat ./proxy/juicity/client)
echo ""
echo ""
echo ""
echo "Server setup has been completed, configuration URIs are provided above"