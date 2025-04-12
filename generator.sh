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
certbot certonly --manual --agree-tos --no-eff-email --preferred-challenges dns-01 -d *.$domain --email $email --server https://acme-v02.api.letsencrypt.org/directory

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