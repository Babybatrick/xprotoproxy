#!/usr/bin/env bash

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