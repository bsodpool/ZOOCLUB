#!/bin/sh
Green=$(echo '\033[00;32m')
Cyan=$(echo '\033[00;36m')
RED=$(echo '\033[00;31m')
YELLOW=$(echo  '\033[00;33m')
echo "${Green}Im Starting to update!"
sudo apt-get update
echo "${Green}I've Finished updating! Now I need to upgrade."
sudo apt-get upgrade
echo "${Green}I've finished upgrading! Now I need to install dependencies"
sudo apt-get install nano unzip software-properties-common
sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev
sudo apt-get install libboost-program-options-dev libboost-test-dev libboost-thread-dev
sudo apt-get install libminiupnpc-dev libzmq3-dev
sudo apt-get install htop
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install libdb4.8-dev libdb4.8++-dev
echo "${Green}I've finished installing dependencies! Now I'll make folders and download the wallet."
mkdir zoocoin
wget https://github.com/AndyMoriss/ZOOCLUB/releases/download/1.0/zoocoind-daemon-precompiled.zip
unzip zoocoind-daemon-precompiled.zip -d zoocoin
cd zoocoin
chmod +x zoocoind
chmod +x zoocoin-cli
./zoocoind -daemon
echo "${Green}I've finished making folders and downloading the wallet! Now I'll create your zoocoin.conf file."
cd /root/.zoocoin/
touch /root/.zoocoin/zoocoin.conf
touch /root/.zoocoin/masternode.conf
echo "rpcallowip=127.0.0.1" >> /root/.zoocoin/zoocoin.conf
sleep 5
echo "${Green}Enter an RPC username (It doesn't matter really what it is, just try to make it secure)"
read username
echo "rpcuser=$username" >> /root/.zoocoin/zoocoin.conf
echo "${Green}Enter an RPC password(It doesn't matter really what it is, just try to make it secure)"
read password
echo "rpcpassword=$password" >> /root/.zoocoin/zoocoin.conf
echo "server=1" >> /root/.zoocoin/zoocoin.conf
echo "listen=1" >> /root/.zoocoin/zoocoin.conf
echo "staking=1" >> /root/.zoocoin/zoocoin.conf
echo "port=60013" >> /root/.zoocoin/zoocoin.conf
echo "masternode=1" >> /root/.zoocoin/zoocoin.conf
echo "${Green}What is the Global IP of your VPS? I'll put this into your config file for you because I'm so nice."
read VPSip
echo "externalip=$VPSip:60013" >> /root/.zoocoin/zoocoin.conf
echo "${Green}What is your masternode genkey? I'll put this into your config file."
read genkey
echo "masternodeprivkey=$genkey" >> /root/.zoocoin/zoocoin.conf
echo "addnode=199.247.29.183:60013
addnode=207.148.90.84:60013
addnode=45.76.163.171:60013
addnode=207.246.97.130:60013
addnode=45.77.227.249:60013
addnode-45.32.32.187:60013" >> /root/.zoocoin/zoocoin.conf
echo "${YELLOW}Okay, it looks like you are all set. Let's startup the daemon!"
cd
cd zoocoin
./zoocoind -daemon
