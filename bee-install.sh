##!/usr/bin/env bash
_PATH=/swarm
_CRONPATH=/var/spool/cron/crontabs/root

echo "安装 JQ START"
sudo apt-get update
apt-get install -y jq
echo "安装 JQ END"

echo "下载相关文件 START"
wget https://github.com/ethersphere/bee/releases/download/v0.5.3/bee_0.5.3_amd64.deb
wget https://github.com/ethersphere/bee-clef/releases/download/v0.4.9/bee-clef_0.4.9_amd64.deb
wget -O cashout.sh https://raw.githubusercontent.com/gongdesheng/test/main/cashout.sh && chmod +x cashout.sh
wget -O get-bee-key.sh https://raw.githubusercontent.com/gongdesheng/test/main/get-bee-key.sh && chmod +x get-bee-key.sh
wget -O bee.yaml https://raw.githubusercontent.com/gongdesheng/test/main/bee.yaml
echo "下载相关文件 END"

echo "安装 bee START"
sudo dpkg -i bee-clef_0.4.9_amd64.deb
sleep 1
sudo dpkg -i bee_0.5.3_amd64.deb
sleep 1
sudo cp /swarm/bee.yaml /etc/bee/
sleep 2
sudo chown -R bee:bee /var/lib/bee
echo "安装 bee END"

echo "创建定时任务 START"
echo "*/30 * * * * /swarm/cashout.sh cashout-all >> /swarm/cron.log 2>&1 &" >> ${_CRONPATH}
echo $(crontab -l)
sudo service cron {reload,restart}
echo "创建定时任务 END"

echo "钱包地址"
sudo bee-get-addr

exit 0
