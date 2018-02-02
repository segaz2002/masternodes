sudo apt-get update -y
apt-get upgrade -y
sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev libboost-all-dev autoconf automake
sudo apt-get install libzmq3-dev libminiupnpc-dev libssl-dev libevent-dev -y
sudo apt-get install git
git clone https://github.com/shekeltechnologies/JewNew.git
add-apt-repository ppa:bitcoin/bitcoin
apt-get install software-properties-common
apt-get install libdb-dev libdb++-dev

fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab


cd JewNew
chmod +x autogen.sh
cd share
chmod +x genbuild.sh
cd ..
cd src
cd leveldb
chmod +x build_detect_platform
cd ..
cd ..
./autogen.sh
./configure --with-incompatible-bdb
make
make install


RPC_PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

echo rpcuser=shekelrpc >> /root/.shekel/shekel.conf
echo rpcpassword=$RPC_PASSWORD >> /root/.shekel/shekel.conf
shekeld -daemon
