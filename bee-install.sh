##!/usr/bin/env bash
_PATH=/swarm
_CRONPATH=/var/spool/cron/crontabs/root
mkdir ${_PATH}
cd ${_PATH}

echo "安装 JQ START"
sudo apt-get update
apt-get install -y jq
echo "安装 JQ END"

wget https://github.com/ethersphere/bee/releases/download/v0.5.3/bee_0.5.3_amd64.deb
wget https://github.com/ethersphere/bee-clef/releases/download/v0.4.9/bee-clef_0.4.9_amd64.deb
wget -O cashout.sh https://raw.githubusercontent.com/gongdesheng/test/main/cashout.sh && chmod +x cashout.sh
wget -O get-bee-key.sh https://raw.githubusercontent.com/gongdesheng/test/main/get-bee-key.sh && chmod +x get-bee-key.sh

echo "安装 bee START"
sudo dpkg -i bee-clef_0.4.9_amd64.deb
sudo dpkg -i bee_0.5.3_amd64.deb
echo "安装 bee END"
sudo bee-get-addr

echo "创建定时任务 START"
echo "*/30 * * * * /swarm/cashout.sh cashout-all >> /swarm/cron.log" >> ${_CRONPATH}
echo "创建定时任务 END"

exit 0
