#!/bin/bash

# This shell is for Ubuntu, another install guide is 
# https://github.com/openvswitch/of-config/blob/master/INSTALL.Vagrant.md

# install libnetconf
echo "----Installing build tools----"
apt-get install autoconf automake libtool cmake python-dev

cd ~
mkdir ovs && cd ovs

echo "----Installing xml----"
wget https://git.gnome.org/browse/libxml2/snapshot/libxml2-2.9.8.tar.xz
tar -xf libxml2-2.9.8.tar.xz && cd libxml2-2.9.8
./autogen.sh
make && make install

cd ..

echo "----Installing xslt----"
wget https://git.gnome.org/browse/libxslt/snapshot/libxslt-1.1.32.tar.xz
tar -xf libxslt-1.1.32.tar.xz && cd libxslt-1.1.32
./autogen.sh
make && make install

cd ..

echo "----Installing openssl----"
wget https://www.openssl.org/source/openssl-1.1.1-pre2.tar.gz
tar -xf openssl-1.1.1-pre2.tar.gz && cd openssl-1.1.1-pre2
./config
make && make install

cd ..

echo "Installing libssh----"
wget https://red.libssh.org/attachments/download/218/libssh-0.7.5.tar.xz
tar -xf libssh-0.7.5.tar.xz && cd libssh-0.7.5
mkdir build && cd build
cmake ..
make && make install
cd ..

cd ..

echo "----Installing curl----"
wget https://curl.haxx.se/download/curl-7.58.0.tar.gz
tar -xf curl-7.58.0.tar.gz && cd curl-7.58.0
./configure && make && make install

cd ..

echo "----Installing libnetconf----"
git clone https://github.com/CESNET/libnetconf
cd libnetconf
./configure && make && make install

cd ..

# install pyang module
echo "----Installing pyang----"
wget https://pyang.googlecode.com/files/pyang-1.4.1.tar.gz
tar -xf pyang-1.4.1.tar.gz && cd pyang-1.4.1
python setup.py install

cd ..

# install ovs 2.3
echo "----Installing ovs 2.3----"
wget https://github.com/openvswitch/ovs/archive/v2.3.tar.gz
tar zxvf v2.3.tar.gz && cd ovs-2.3
./configure --with-linux=/lib/modules/`uname -r`/build
make && make install

cd ..

# install of-config
echo "----Installing of-config----"
git clone https://github.com/openvswitch/of-config
cd of-config
./configure --with-ovs-srcdir=/root/ovs/ovs-2.3 --disable-dbus
make && make install

cd ..

# install netconf client

apt-get install libreadline6 libreadline6-dev

echo "----Installing netopeer-cli----"
git clone https://github.com/CESNET/netopeer
cd netopeer/cli
./configure && make && make install

# return to ovs dir
cd ../..

