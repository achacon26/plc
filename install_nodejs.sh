#! /bin/bash
cd /tmp || exit

node_version=$1
install_folder=$2

if [ -z "$node_version" ]
then
    read -rp "Please insert the NodeJS version: " node_version
fi

if [ -z "$install_folder" ]
then
    install_folder="/usr"
fi

echo "Installing NodeJS v$node_version..."

wget https://nodejs.org/dist/v"$node_version"/node-v"$node_version"-linux-armv7l.tar.xz || exit
echo "Unzipping node-v$node_version-linux-armv7l.tar.xz..."
tar -xJf ./node-v"$node_version"-linux-armv7l.tar.xz || exit
rm -f node-v"$node_version"-linux-armv7l.tar.xz

echo "Deploing NodeJS files..."
rm -Rf "$install_folder"/local/node
mkdir -p "$install_folder"/local/node || exit
mv ./node-v"$node_version"-linux-armv7l/* "$install_folder"/local/node
rm -Rf node-v"$node_version"-linux-armv7l
rm -f /usr/bin/node
ln -s "$install_folder"/local/node/bin/node /usr/bin/node
rm -f /usr/bin/npm
ln -s "$install_folder"/local/node/bin/npm /usr/bin/npm
rm -f /usr/bin/npx
ln -s "$install_folder"/local/node/bin/npx /usr/bin/npx

echo "Installing libatomic1..."

wget http://ftp.au.debian.org/debian/pool/main/g/gcc-14/libatomic1_14-20240429-1_armhf.deb
ar x ./libatomic1_14-20240429-1_armhf.deb
rm -f libatomic1_14-20240429-1_armhf.deb

echo "Unzipping libatomic..."
tar -xJf data.tar.xz
rm -f data.tar.xz
rm -f control.tar.xz
rm -Rf debian-binary

echo "Deploing libatomic1 files..."
rm -f /usr/lib/libatomic*
mkdir -p "$install_folder"/lib || exit
mv ./usr/lib/arm-linux-gnueabihf/* "$install_folder"/lib/ || exit
rm -Rf ./usr

if [ "$install_folder/lib/" != "/usr/lib" ]
then
    ln -s "$install_folder"/lib/libatomic.so.1.2.0 /usr/lib/libatomic.so.1
fi

echo "Checking NodeJS version:"
node -v
echo "Checking NPM version:"
npm -v
echo "Checking NPX version:"
npx -v

echo "NodeJS v$node_version instalation finalized."
