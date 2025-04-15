#!/usr/bin/env bash

cat << EOF > xproto.conf
PASSWORD=$(openssl rand -base64 48 | tr '/+' 'xQ')
OBFPASSWORD=$(openssl rand -base64 48 | tr '/+' 'xQ')
UUID=$(uuidgen)
DOMAIN=${domain}
EMAIL=${email}
CERTPATH=${certpath}
PKEYPATH=${pkeypath}
LOCALCERTPATH=${localcertpath}
LOCALPKEYPATH=${localpkeypath}
EOF