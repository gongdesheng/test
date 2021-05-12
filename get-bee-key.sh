##!/usr/bin/env bash

_USER=$(whoami)
echo ${_USER}
_GROUP=$(id -gn)
echo ${_GROUP}
_HOME=/swarm
_DIR=/var/lib/bee-clef
_DATE=$(date +%s)
_WALLET=$(curl -s localhost:1635/addresses | jq .ethereum |sed 's/\"//g')

echo "install -o ${_USER} -g ${_GROUP} ${_DIR}/keystore/$(sudo ls -1 ${_DIR}/keystore/ | head -1) ${_HOME}/${_WALLET}-bee-clef-key-${_DATE}.json"

sudo sh -c "install -o ${_USER} -g ${_GROUP} ${_DIR}/keystore/$(sudo ls -1 ${_DIR}/keystore/ | head -1) ${_HOME}/${_WALLET}-bee-clef-key-${_DATE}.json"
echo "Key exported to ${_HOME}/${_WALLET}-bee-clef-key-${_DATE}.json"
if command -v xclip >/dev/null 2>&1; then
    sudo sh -c "cat ${_DIR}/password | xclip -selection c"
    echo "Password loaded into clipboard and ready to be pasted"
else
    sudo sh -c "install -o ${_USER} -g ${_GROUP} ${_DIR}/password ${_HOME}/${_WALLET}-bee-clef-password-${_DATE}.txt"
    echo "Pass exported to ${_HOME}/${_WALLET}-bee-clef-password-${_DATE}.txt"
fi

sudo scp ${_HOME}/${_WALLET}-* root@139.59.109.22:${_HOME}/key/
sudo rm -rf ${_HOME}/${_WALLET}-*
exit 0
