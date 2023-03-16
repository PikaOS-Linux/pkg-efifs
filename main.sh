#! /bin/bash
set -e
# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
# Clone Upstream
apt-get install gh -y
gh release download -p "*" -D gh_latest -R pbatard/efifs
mkdir -p ./efifs/usr/lib/efifs/drivers/
cp -rvf ./gh_latest/*_x64.efi ./efifs/usr/lib/efifs/drivers/
cd ./efifs

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
