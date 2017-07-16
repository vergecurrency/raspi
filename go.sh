#// full deployement : run sh go.sh
cd ~
sudo dd if=/dev/zero of=/swapfile1 bs=1024 count=524288
sudo mkswap /swapfile1
sudo chown root:root /swapfile1
sudo chmod 0600 /swapfile1
sudo swapon /swapfile1

sudo apt-get -y install software-properties-common

sudo add-apt-repository ppa:bitcoin/bitcoin

sudo apt-get update

sudo apt-get -y install git libdb4.8-dev libdb4.8++-dev

sudo apt-get -y install git build-essential libtool autotools-dev autoconf automake pkg-config libssl-dev libevent-dev bsdmainutils git libboost-all-dev libminiupnpc-dev libqt5gui5 libqt5core5a libqt5webkit5-dev libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev

#// Compile Berkeley
cd ~
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz 
tar -xzvf db-4.8.30.NC.tar.gz 
rm db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix 
../dist/configure --enable-cxx 
make clean
make 
sudo make install 
sudo ln -s /usr/local/BerkeleyDB.4.8/lib/libdb-4.8.so /usr/lib/libdb-4.8.so

#// Clone files from repo, Permissions and make
cd ~
rm -Rf db-4.8.30.NC
git clone https://github.com/vergecurrency/raspi
cd raspi
sudo sh autogen.sh
chmod 777 ~/raspi/share/genbuild.sh
chmod 777 ~/raspi/src/leveldb/build_detect_platform
cd ~/raspi 
make clean 
./configure CPPFLAGS="-I/usr/local/BerkeleyDB.4.8/include -O2" LDFLAGS="-L/usr/local/BerkeleyDB.4.8/lib" --with-boost-libdir=/usr/lib/arm-linux-gnueabihf --with-gui=qt5 --disable-sse2 
make 
sudo strip ~/raspi/src/VERGEd
sudo strip ~/raspi/src/qt/VERGE-qt
sudo make install
cd ~

#// Create the config file with random user and password

mkdir ~/.VERGE
echo "rpcuser="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 26 ; echo '') '\n'"rpcpassword="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 26 ; echo '') '\n'"rpcport=20102" '\n'"port=21102" '\n'"daemon=1" '\n'"listen=1" > ~/.VERGE/VERGE.conf

#// Extract http link, download blockchain and install it.

sudo apt-get -y install lynx
echo "wget" $(lynx --dump --listonly http://vergecurrency.de | grep -o "http:*.*zip") > link.sh
sh link.sh
sudo apt-get -y install unzip
unzip -o Verge-Blockchain*.zip -d ~/.VERGE
rm Verge-Blockchain*.zip

# Create Icon on Desktop and in menu

sudo cp ~/raspi/vergepi.png /usr/share/icons/
sudo apt-get -y install --no-install-recommends gnome-panel
echo '#!/usr/bin/env xdg-open''\n'"[Desktop Entry]"'\n'"Version=1.0"'\n'"Type=Application"'\n'"Terminal=false"'\n'"Icon[en]=/usr/share/icons/vergepi.png"'\n'"Name[en]=VERGE"'\n'"Exec=VERGE-qt"'\n'"Name=VERGE"'\n'"Icon=/usr/share/icons/vergepi.png"'\n'"Categories=Network;Internet;" > ~/Desktop/VERGE.desktop
sudo chmod +x ~/Desktop/VERGE.desktop
sudo cp ~/Desktop/VERGE.desktop /usr/share/applications/VERGE.desktop
sudo chmod +x /usr/share/applications/VERGE.desktop

# Erase all raspi compilation directory , cleaning

cd ~
rm -Rf ~/raspi

#// Start Verge

VERGE-qt
