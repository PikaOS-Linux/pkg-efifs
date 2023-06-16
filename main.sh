#! /bin/bash
set -e

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
