# 清除大部分端口
# firewall-cmd --zone=public --remove-port=${xinduan}/tcp --permanent  &&
# firewall-cmd --reload  &&

# 修改端口
file="/etc/ss-config.json"  
hang=`cat ${file} | grep "server_port"` 
jiuduan=`echo $hang | cut -c15-19` 

# 随机函数
function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(($RANDOM+1000000000)) #增加一个10位的数再求余
    echo $(($num%$max+$min))
}

# 随机端口1024-65000之间
xinduan=$(rand 1024 65000)
sed -i 's/'$jiuduan'/'$xinduan'/g' /etc/ss-config.json
jiuduan=$(cat /etc/kcp-config.json|grep 'target'|cut -c25-29)

# 端口替换
sed -i 's/'$jiuduan'/'$xinduan'/g' /etc/kcp-config.json

# 修改加密方式################################################
mimahang=`cat ${file} | grep "method"`
len=`expr length $mimahang`
# 密码长度-1 使用cut获取密码
len=$[$len-1]
jiujiami=`echo $mimahang | cut -c11-$len`

# 利用数组实现一个随机加密
jiami_array=(rc4-md5 salsa20 chacha20 chacha20-ietf aes-256-cfb aes-192-cfb aes-128-cfb aes-256-ctr aes-192-ctr aes-128-ctr bf-cfb camellia-128-cfb camellia-192-cfb camellia-256-cfb aes-128-gcm aes-192-gcm aes-256-gcm chacha20-ietf-poly1305)
shuzulen=${#jiami_array[*]}
suiji=$(rand 0 $[$shuzulen-1])
# 数组下标作为随机数 实现随机数组元素的引用 继而实现随机加密方式
suijijiami=${jiami_array[$suiji]}
sed -i 's/'$jiujiami'/'$suijijiami'/g' /etc/ss-config.json

# 自启动防火墙并且重载 使设置生效######################
systemctl start firewalld  &&
systemctl enable firewalld.service  &&
firewall-cmd --zone=public --add-port=${xinduan}/tcp --permanent  &&
firewall-cmd --reload  &&

# 开启ss#################
systemctl start shadowsocks-server  &&
systemctl restart shadowsocks-server  &&
systemctl enable shadowsocks-server  &&

# 开启kcp#######################
systemctl start kcp-server  &&
systemctl restart kcp-server  &&
systemctl enable kcp-server  &&

# 先试一下两个配置文件参数################
cat /etc/ss-config.json &&
cd / && cat /etc/kcp-config.json &&

# 需要客户端填写的参数#############
ifconfig eth0 |grep 'inet ' |cut -d " " -f 10 &&
cat /etc/ss-config.json|grep 'server_port'|cut -c19-23&&
cat /etc/ss-config.json|grep 'password'|cut -c17-28&&
echo $jiujiami
