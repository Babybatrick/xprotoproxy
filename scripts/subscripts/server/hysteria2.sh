#!/usr/bin/env bash

source .env

cat > ./proxy/hysteria2/config.json <<EOF
{
    "listen": ":443",
    "tls": {
        "cert": "$CERTPATH",
        "key": "$PKEYPATH",
        "sniGuard": "strict"
    },
    "obfs": {
        "type": "salamander",
        "salamander": {
            "password": "$OBFPASSWORD"
        }
    },
    "bandwidth": {
        "up": "1 gbps",
        "down": "1 gbps"
    },
    "ignoreClientBandwidth": false,
    "speedTest": false,
    "disableUDP": false,
    "udpIdleTimeout": "120s",
    "auth": {
        "type": "password",
        "password": "$PASSWORD"
    },
    "sniff": {
        "enable": true,
        "timeout": "2s",
        "rewriteDomain": false,
        "tcpPorts": "80,443,8000-9000",
        "udpPorts": "all"
    },
    "masquerade": {
        "type": "proxy",
        "proxy": {
            "url": "https://baidu.com/",
            "rewriteHost": true
        }
    }
}
EOF