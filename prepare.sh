#!/usr/bin/env bash

#THIS SCRIPT PREPARES THE ENVIRONMENT FOR THE APPLICATION
#IT INSTALLS TOOLS LIKE DOCKER FOR PROPER APP DEPLYOMENT
echo "Installing dependancies"
echo ""

#    Installing UUID generator
command -v uuidgen &> /dev/null || apt install uuid-runtime -qqy >/dev/null 2>/dev/null || { echo "uuid-runtime failed to install, exiting..."; exit 1; }
#
#    Installing Certbot
command -v certbot &> /dev/null || apt install certbot -qqy >/dev/null 2>/dev/null || { echo "certbot failed to install, exiting..."; exit 1; }
#
#    Installing QREncode
command -v qrencode &> /dev/null || apt install qrencode -qqy >/dev/null 2>/dev/null || { echo "qrencode failed to install, exiting..."; exit 1; }
#
#    Installing Curl
command -v curl &> /dev/null ||  apt install curl -qqy >/dev/null 2>/dev/null || { echo "curl failed to install, exiting..."; exit 1; }
#
#    Installing Docker
command -v docker &> /dev/null || { curl -fsSL https://get.docker.com -o get-docker.sh >/dev/null && sh get-docker.sh >/dev/null; } || { echo "Docker failed to install, exiting..."; exit 1; }

echo "Dependancies prepared, proceeding"
./generator.sh