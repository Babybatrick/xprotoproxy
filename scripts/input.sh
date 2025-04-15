#!/usr/bin/env bash

#INPUTTING DOMAIN
read -p "Enter a domain name: " domain
[[ $domain =~ ^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$ ]] && echo "Proceeding" && echo "" || { echo "Invalid domain name, exiting..."; exit 1; }

#INPUTTING EMAIN
read -p "Enter an email address: " email
[[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]] && echo "Proceeding" && echo "" || { echo "Invalid email address, exiting..."; exit 1; }