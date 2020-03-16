# 修改端口
file="/etc/ss-config.json"  
hang=`cat ${file} | grep "server_port"` 
jiuduan=`echo $hang | cut -c15-19` 
function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(($RANDOM+1000000000)) #增加一个10位的数再求余
    echo $(($num%$max+$min))
}
xinduan=$(rand 1024 65000)
sed -i 's/'$jiuduan'/'$xinduan'/g' /etc/ss-config.json

xinduan=$(cat /etc/ss-config.json|grep 'server_port'|cut -c19-23)
jiuduan=$(cat /etc/kcp-config.json|grep 'target'|cut -c25-29)
sed -i 's/'$jiuduan'/'$xinduan'/g' /etc/kcp-config.json

xinduan=$(cat /etc/ss-config.json|grep 'server_port'|cut -c19-23)

# 修改加密方式
file="/etc/ss-config.json"
hang=`cat ${file} | grep "method"`
len=`expr length $hang`
len=$[$len-1]
jiujiami=`echo $hang | cut -c11-$len`
# echo $jiuduan
jiami_array=(rc4-md5 salsa20 chacha20 chacha20-ietf aes-256-cfb aes-192-cfb aes-128-cfb aes-256-ctr aes-192-ctr aes-128-ctr bf-cfb camellia-128-cfb camellia-192-cfb camellia-256-cfb aes-128-gcm aes-192-gcm aes-256-gcm chacha20-ietf-poly1305)
shuzulen=${#jiami_array[*]}
suiji=$(rand 0 $[$shuzulen-1])
# echo ${jiami_array[$suiji]}
suijijiami=${jiami_array[$suiji]}
sed -i 's/'$jiujiami'/'$suijijiami'/g' /etc/ss-config.json

systemctl start firewalld  &&
systemctl enable firewalld.service  &&
firewall-cmd --zone=public --add-port=${xinduan}/tcp --permanent  &&
firewall-cmd --reload  &&
systemctl start shadowsocks-server  &&
systemctl restart shadowsocks-server  &&
systemctl enable shadowsocks-server  &&
systemctl start kcp-server  &&
systemctl restart kcp-server  &&
systemctl enable kcp-server  &&
cat /etc/ss-config.json &&
cd / && cat /etc/kcp-config.json &&

ifconfig eth0 |grep 'inet ' |cut -d " " -f 10 &&
cat /etc/ss-config.json|grep 'server_port'|cut -c19-23&&
cat /etc/ss-config.json|grep 'password'|cut -c17-28&&
echo $jiujiami
