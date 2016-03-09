[![Build Status](https://travis-ci.org/vergecurrency/raspi.svg?branch=master)](https://travis-ci.org/vergecurrency/raspi)

![raspi](https://raw.githubusercontent.com/vergecurrency/raspi/master/vergepi.png)
```
____   _________________________   ________ ___________
\   \ /   /\_   _____/\______   \ /  _____/ \_   _____/
 \   Y   /  |    __)_  |       _//   \  ___  |    __)_ 
  \     /   |        \ |    |   \\    \_\  \ |        \ 2016 VERGE/XVG
   \___/   /_______  / |____|_  / \______  //_______  /
                   \/         \/         \/         \/ 
```
VERGE [XVG] Raspberry Pi Source Code
================================

Specifications:
--------------

* Algorithm: scrypt
* PoW (proof of work)
* Blocktime: ~5 minutes
* RPC port: 20102
* P2P port: 21102
* Blockreward: 
  * Block 0 to 14,000 : 200,000 coins
  * 14,000 to 28,000 : 100,000 coins
  * 28,000 to 42,000: 50,000 coins
  * 42,000 to 210,000: 25,000 coins
  * 210,000 to 378,000: 12,500 coins
  * 378,000 to 546,000: 6,250 coins
  * 546,000 to 714,000: 3,125 coins
  * 714,000 to 2,124,000: 1,560 coins
  * 2,124,000 to 4,248,000: 730 coins

Total Supply
------------

Approximately total reward: 9 Billion (9,000,000,000) during first year then issuing 1 billion (1,000,000,000) each year after.


Compiling Linux Wallet
----------------------

if you have never compiled a wallet on a raspberry pi before, here are the dependencies you will need:

    sudo apt-get install build-essential pkg-config libtool autotools-dev autoconf automake libssl-dev libboost-all-dev  libminiupnpc-dev libdb++-dev libdb-dev qt4-qmake libqt4-dev libqrencode-dev libssl-dev git

to clone and compile:

    git clone https://github.com/vergecurrency/raspi && cd raspi/src && make -f makefile.unix

to make the qt gui wallet:

    git clone https://github.com/vergecurrency/raspi && cd raspi && qmake && make


If you receive the following error:
*********************************************************************
g++: internal compiler error: Killed (program cc1plus)
Please submit a full bug report,
with preprocessed source if appropriate.
See <file:///usr/share/doc/gcc-4.6/README.Bugs> for instructions.
make: *** [obj/checkpoints.o] Error 4

please follow the below steps:

$ sudo dd if=/dev/zero of=/swapfile1 bs=1024 count=524288 

$ sudo mkswap /swapfile1

$ sudo chown root:root /swapfile1

$ sudo chmod 0600 /swapfile1

$ sudo swapon /swapfile1

Then you edit your fstab
$sudo nano /etc/fstab

append the following

/swapfile1 swap swap defaults 0 0

Then you can check it is working with 

free -m 

Re-run the Compile command "make -f makefile.unix" after creating the new swap file.
*********************************************************************

Afterwords

type `sudo cp ~/raspi/src/verged /usr/bin/` after you have typed that. Your Verge daemon will now be accessible system wide.

after that has been done, type cd ~/ to get back to the home folder and type `verged` this will tell you that you need to make a VERGE.conf with it supplying you an output

that you can choose or not choose to use. So once you've ran that, then type `cd ~/.VERGE`, after that has been done type `sudo nano VERGE.conf`, paste the output from the `verged` command into the VERGE.conf like so
```
rpcuser=bitcoinrpc
rpcpassword=85CpSuCNvDcYsdQU8w621mkQqJAimSQwCSJL5dPT9wQX - THESE ARE EXAMPLES
```
Once that has been completed proceed to add `rpcport=20102 port=21102 and daemon=1` below the rpcpassword. your config should look something like this
```
rpcuser=bitcoinrpc
rpcpassword=85CpSuCNvDcYsdQU8w621mkQqJAimSQwCSJL5dPT9wQX
rpcport=20102
port=21102
daemon=1
```
now exit the VERGE.conf by pressing ctrl + x on your keyboard then pressing `y` and hitting enter. this should have made your .conf save with all the stuff you just added,
if you wish you can check again by typing sudo nano VERGE.conf. After you've checked then exit the file the exact same way, then type `cd ~/` as before i said this takes you back to your home folder, you can now type verged and your verge daemon should boot.
To check the status of how much is synced type `verged getinfo`

Live Chat
---------

come check out our live chat:
[![Visit our IRC Chat!](https://kiwiirc.com/buttons/chat.freenode.net/verge.png)](https://kiwiirc.com/client/chat.freenode.net/?nick=xvg|?&theme=cli#verge)


