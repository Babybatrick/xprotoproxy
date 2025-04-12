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

cat > ./proxy/shadowsocks/config.json <<EOF
{ 
  "server":"0.0.0.0", 
  "server_port":443, 
  "local_port":1080, 
  "password":"$PASSWORD", 
  "method":"chacha20-ietf-poly1305" 
}
EOF

cat > ./proxy/juicity/config.json <<EOF
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
EOF

cat > ./proxy/trojan/config.json <<EOF
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "\$remote_addr": "127.0.0.1",
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
EOF

cat > ./proxy/brook/config.json <<EOF
{
  "listen": ":443",
  "password":"$PASSWORD",
  "domainaddress": "$DOMAIN",
  "cert": "$CERTPATH",
  "certkey": "$PKEYPATH",
  "udpTimeout": "120"
}
EOF

cat > ./proxy/socks5/config.json <<EOF
{
  "listen": ":443",
  "users": {"$UUID": "$PASSWORD"},
}
EOF

cat > ./proxy/snell/config.ini <<EOF
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
EOF

cat > ./proxy/tuic/config.json <<EOF
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
EOF

cat > ./proxy/nginx/nginx.conf <<EOF
http {
    server {
        listen 443;
        server_name 0xhy.$DOMAIN;
        # Reverse proxy for Hysteria2
        location / {
            proxy_pass http://hysteria2:443;
            proxy_set_header Host example.com;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }

    server {
        listen 443;
        server_name 0xss.$DOMAIN;

        ssl_certificate $CERTPATH;
        ssl_certificate_key $PKEYPATH;

        # Reverse proxy for Shadowsocks
        location / {
            proxy_pass http://shadowsocks:443;
            proxy_set_header Host example.com;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }

    server {
        listen 443;
        server_name 0xjc.$DOMAIN;

        ssl_certificate $CERTPATH;
        ssl_certificate_key $PKEYPATH;

        # Reverse proxy for Juicity
        location / {
            proxy_pass http://juicity:443;
            proxy_set_header Host example.com;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }

    server {
        listen 443;
        server_name 0xtj.$DOMAIN;

        ssl_certificate $CERTPATH;
        ssl_certificate_key $PKEYPATH;
        
        # Reverse proxy for Trojan
        location / {
            proxy_pass http://trojan:443;
            proxy_set_header Host example.com;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }

    server {
        listen 443;
        server_name 0xbk.$DOMAIN;

        ssl_certificate $CERTPATH;
        ssl_certificate_key $PKEYPATH;
        
        # Reverse proxy for Brook
        location / {
            proxy_pass http://brook:443;
            proxy_set_header Host example.com;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }

    server {
        listen 443;
        server_name 0xs5.$DOMAIN;

        ssl_certificate $CERTPATH;
        ssl_certificate_key $PKEYPATH;
        
        # Reverse proxy for Socks5
        location / {
            proxy_pass http://socks5:443;
            proxy_set_header Host example.com;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }

    server {
        listen 443;
        server_name 0xsl.$DOMAIN;

        ssl_certificate $CERTPATH;
        ssl_certificate_key $PKEYPATH;
        
        # Reverse proxy for Snell
        location / {
            proxy_pass http://snell:443;
            proxy_set_header Host example.com;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }

    server {
        listen 443;
        server_name 0xtc.$DOMAIN;

        ssl_certificate $CERTPATH;
        ssl_certificate_key $PKEYPATH;
        
        # Reverse proxy for TUIC
        location / {
            proxy_pass http://tuic:443;
            proxy_set_header Host example.com;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }

    # Fallback for unmatched requests
    server {
        listen 443 default_server;
        server_name _;

        location / {
            return 404;
        }
    }
}
EOF