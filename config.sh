#!/usr/bin/env bash

source .env

cat > ./proxy/hysteria2/config.json <<EOL
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
EOL

cat > ./proxy/shadowsocks/config.json <<EOL
{ 
  "server":"0.0.0.0", 
  "server_port":443, 
  "local_port":1080, 
  "password":"$PASSWORD", 
  "method":"chacha20-ietf-poly1305" 
}
EOL

cat > ./proxy/juicity/config.json <<EOL
{
  "listen": ":443",
  "users": {
    "$UUID": "$PASSWORD"
  },
  "certificate": "$CERTPATH",
  "private_key": "$PKEYPATH",
  "congestion_control": "bbr",
  "log_level": "info"
}
EOL

cat > ./proxy/trojan/config.json <<EOL
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": "$PASSWORD",
    "log_level": 1,
    "ssl": {
        "cert": "$CERTPATH",
        "key": "$PKEYPATH",
        "key_password": "",
        "cipher": "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384",
        "cipher_tls13": "TLS_AES_128_GCM_SHA256:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_256_GCM_SHA384",
        "prefer_server_cipher": true,
        "alpn": [
            "http/1.1"
        ],
        "alpn_port_override": {
            "h2": 81
        },
        "reuse_session": true,
        "session_ticket": false,
        "session_timeout": 600,
        "plain_http_response": "",
        "curves": "",
        "dhparam": ""
    },
    "tcp": {
        "prefer_ipv4": false,
        "no_delay": true,
        "keep_alive": true,
        "reuse_port": true,
        "fast_open": false,
        "fast_open_qlen": 20
    }
}
EOL

cat > ./proxy/brook/config.json <<EOL
{
  "listen": ":443",
  "password":"$PASSWORD",
  "domainaddress": "$DOMAIN",
  "cert": "$CERTPATH",
  "certkey": "$PKEYPATH",
  "udpTimeout": "120"
}
EOL

cat > ./proxy/socks5/config.json <<EOL
{
  "listen": ":443",
  "users": {"$UUID": "$PASSWORD"},
}
EOL

cat > ./proxy/snell/config.ini <<EOL
[snell-server]
listen = 0.0.0.0:443
psk = $PASSWORD
obfs = tls
obfs-host = www.baidu.com
ipv6 = true
reuse-port = true
udp = true
udp-max-size = 4096
timeout = 600
dns = 1.1.1.1,1.0.0.1
EOL

cat > ./proxy/tuic/config.json <<EOL
{
    "server": "[::]:443",
    "users": {
        "$UUID": "$PASSWORD"
    },
    "certificate": "$CERTPATH",
    "private_key": "$PKEYPATH",
    "congestion_control": "bbr",
    "alpn": ["h3"],
    "udp_relay_ipv6": true,
    "zero_rtt_handshake": false,
    "dual_stack": true,
    "auth_timeout": "3s",
    "task_negotiation_timeout": "3s",
    "max_idle_time": "10s",
    "send_window": 16777216,
    "receive_window": 8388608,
    "gc_interval": "3s",
    "gc_lifetime": "15s",
    "log_level": "info"
}
EOL