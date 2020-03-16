# 卸载shadowsocks-server
systemctl stop shadowsocks-server&&
rm -f /etc/ss-config.json /etc/systemd/system/shadowsocks-server.service&&
systemctl daemon-reload&&

# 卸载kcptun
systemctl stop kcp-server&&
rm -f /etc/kcp-config.json /etc/systemd/system/kcp-server.service&&
systemctl daemon-reload
