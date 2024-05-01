#!/usr/bin/env bash

node_version=$1
install_folder=$2

if [ -z "$node_version" ]
then
    read -p "Please insert the NodeJS version: " node_version
fi

if [ -z "$install_folder" ]
then
	install_folder="/usr"
fi

echo "Installing NodeJS v$node_version..."

wget https://nodejs.org/dist/v$node_version/node-v$node_version-linux-armv7l.tar.xz
echo "Unzipping node-v$node_version-linux-armv7l.tar.xz..."
tar -xJf node-v$node_version-linux-armv7l.tar.xz
rm node-v$node_version-linux-armv7l.tar.xz

echo "Deploing NodeJS files..."
rm -Rf $install_folder/local/node
mv node-v$node_version-linux-armv7l $install_folder/local/node
rm -Rf node-v$node_version-linux-armv7l
rm $install_folder/bin/node
ln -s $install_folder/local/node/bin/node /usr/bin/node
rm $install_folder/bin/npm
ln -s $install_folder/local/node/bin/npm /usr/bin/npm
rm $install_folder/bin/npx
ln -s $install_folder/local/node/bin/npx /usr/bin/npx

echo "Installing libatomic1..."

wget http://ftp.au.debian.org/debian/pool/main/g/gcc-14/libatomic1_14-20240429-1_armhf.deb
ar x libatomic1_14-20240429-1_armhf.deb
rm libatomic1_14-20240429-1_armhf.deb

echo "Unzipping libatomic..."
tar -xJf data.tar.xz
rm data.tar.xz
rm control.tar.xz
rm -Rf debian-binary

echo "Deploing libatomic1 files..."
rm $install_folder/lib/libatomic*
mv ./usr/lib/arm-linux-gnueabihf/* $install_folder/lib/
rm -Rf ./usr

echo "Checking NodeJS version:"
node -v
echo "Checking NPM version:"
npm -v
echo "Checking NPX version:"
npx -v

echo "NodeJS v$node_version instalation finalized."
