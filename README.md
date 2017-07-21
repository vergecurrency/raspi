
[![Build Status](https://travis-ci.org/vergecurrency/raspi.svg?branch=master)](https://travis-ci.org/vergecurrency/raspi)

![raspi](https://raw.githubusercontent.com/vergecurrency/raspi/master/vergepi.png)
```
____   _________________________   ________ ___________
\   \ /   /\_   _____/\______   \ /  _____/ \_   _____/
 \   Y   /  |    __)_  |       _//   \  ___  |    __)_ 
  \     /   |        \ |    |   \\    \_\  \ |        \ 2017 VERGE/XVG
   \___/   /_______  / |____|_  / \______  //_______  /
                   \/         \/         \/         \/ 
```                
########################################################################

VERGE [XVG]

Raspberry Pi Source Code

Version 2.0

May 22nd 2017

Introduction
#########################################################################
This setup guide walks you through the procedure required to compile and run the Verge [$XVG] Linux wallet on a Raspberry Pi 2B/3. Within this guide you will discover not only how to compile the linux wallet on Linux but also how to troubleshoot common issues associated with compiling a wallet for the first time.

Specifications
#########################################################################
- PoW (proof of work)
- Algorithms: scrypt, x17, Lyra2rev2, myr-groestl, &amp; blake2s
- Blocktime: 30 seconds
- RPC port: 20102
- P2P port: 21102
- Blockreward:
  - Block 0 to 14,000 : 200,000 coins
  - 14,000 to 28,000 : 100,000 coins
  - 28,000 to 42,000: 50,000 coins
  - 42,000 to 210,000: 25,000 coins
  - 210,000 to 378,000: 12,500 coins
  - 378,000 to 546,000: 6,250 coins
  - 546,000 to 714,000: 3,125 coins
  - 714,000 to 2,124,000: 1,560 coins
  - 2,124,000 to 4,248,000: 730 coins

Total Supply
#########################################################################
Approximately total reward: 9 Billion (9,000,000,000) during first year then issuing 1 billion (1,000,000,000) each year after.


Compiling Linux Wallet
#########################################################################

No Brainer, skip below and do:

sudo apt-get install git
cd ~ && git clone https://github.com/vergecurrency/raspi && cd raspi && sh go.sh

If you have never compiled a wallet on a raspberry pi before, here are the dependencies you will need:

```sudo add-apt-repository ppa:bitcoin/bitcoin```

```sudo apt-get update```

```sudo apt-get install git libdb4.8-dev libdb4.8++-dev build-essential libtool autotools-dev autoconf automake pkg-config libssl-dev libevent-dev bsdmainutils git libboost-all-dev libminiupnpc-dev libqt5gui5 libqt5core5a libqt5webkit5-dev libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev```

to clone and compile:

    git clone https://github.com/vergecurrency/raspi && cd raspi/src && make -f makefile.unix

to make the qt gui wallet:

    git clone https://github.com/vergecurrency/raspi && cd raspi && ./autogen.sh && ./configure --with-boost-libdir=/usr/lib/arm-linux-gnueabihf --with-gui=qt5 --disable-sse2 && make

Type
$ sudo cp ~/raspi/src/VERGEd /usr/bin/

Your Verge daemon will now be accessible system wide.

After that has been done, type cd ~/ to get back to the home folder.

Type 'verged'
    1. Copy the output statement
    2. cd ~/.VERGE
    3. $ sudo nano VERGE.conf
    4. Paste the earlier output statement into this config file.
    5. Append the following to the end of the statement
      1. rpcport=20102
      2. port=21102
      3. daemon=1
    6. Ctrl+x and y (Write/Save and quit)

Sample output statement with appended port information.

rpcuser=vergerpcuser
rpcpassword=85CpSuCNvDcYsdQU8w621mkQqJAimSQwCSJL5dPT9wQX
rpcport=20102
port=21102
daemon=1

1. Type cd ~/
2. To check the status of how much is synced type &#39;verged getinfo&#39;

Troubleshooting
#########################################################################
If you receive the following error:

g++: internal compiler error: Killed (program cc1plus)
Please submit a full bug report,
with preprocessed source if appropriate.
See <file:///usr/share/doc/gcc-4.6/README.Bugs> for instructions.
make: *** [obj/checkpoints.o] Error 4

- Follow the below steps:

1. $ sudo dd if=/dev/zero of=/swapfile1 bs=1024 count=524288
2. $ sudo mkswap /swapfile1
3. $ sudo chown root:root /swapfile1
4. $ sudo chmod 0600 /swapfile1
5. $ sudo swapon /swapfile1

-
  - Then you edit your fstab $sudo nano /etc/fstab
    - append the following
    - /swapfile1 swap swap defaults 0 0
      - Then you can check it is working with linux command (free)

Re-run the Compile command &quot;make -f makefile.unix&quot; after creating the new swap file.
 
(Optional) If you have to compile BerkeleyDB4.8:
 
 - cd ~
 - wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
 - tar -xzvf db-4.8.30.NC.tar.gz
 - cd db-4.8.30.NC/build_unix
 - ../dist/configure --enable-cxx
 - make
 - sudo make install
 - sudo ln -s /usr/local/BerkeleyDB.4.8/lib/libdb-4.8.so /usr/lib/libdb-4.8.so
 - sudo ln -s /usr/local/BerkeleyDB.4.8/lib/libdb_cxx-4.8.so /usr/lib/libdb_cxx-4.8.so
 
redo compilation:
 
 - cd ~/raspi
 - make clean
 - ./configure CPPFLAGS="-I/usr/local/BerkeleyDB.4.8/include -O2" LDFLAGS="-L/usr/local/BerkeleyDB.4.8/lib" --with-boost-libdir=/usr/lib/arm-linux-gnueabihf --with-gui=qt5 --disable-sse2
 - make
 - sudo make install
 
Live Chat
---------

come check out our live chat:
[![Visit our IRC Chat!](https://kiwiirc.com/buttons/chat.freenode.net/verge.png)](https://kiwiirc.com/client/chat.freenode.net/?nick=xvg|?&theme=cli#verge)

badbrainirc: DGbYZXxDpkHiMCGNGuf24vJf8jm8pgbRhp
