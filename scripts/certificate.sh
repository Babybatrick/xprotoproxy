#!/usr/bin/env bash

#REQUESTING CERTIFICATE
certbot certonly --standalone -d $domain --non-interactive --agree-tos --no-eff-email --email $email || { echo "Error while generating the certificate, exiting..."; exit 1; }

#CREATING CERTIFICATE PATH VARIABLES
certpath=/etc/letsencrypt/live/$domain/fullchain.pem
pkeypath=/etc/letsencrypt/live/$domain/privkey.pem

#CREATING LOCAL CERTIFICATE PATH VARIABLES
localcertpath=./ssl/fullchain.pem
localpkeypath=./ssl/privkey.pem

#COPYING CERTIFICATES TO LOCAL PATH
cp $certpath $localcertpath
cp $pkeypath $localpkeypath