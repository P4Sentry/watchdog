#!/bin/bash

# p4c dependencies installation
. /etc/os-release
echo "deb https://download.opensuse.org/repositories/home:/p4lang/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/home:p4lang.list
curl -L "https://download.opensuse.org/repositories/home:/p4lang/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y cmake g++ git automake libtool libgc-dev bison flex libfl-dev libboost-dev libboost-iostreams-dev libboost-graph-dev llvm pkg-config python3 python3-pip tcpdump curl docker.io docker-compose p4lang-p4c

curl https://raw.githubusercontent.com/p4lang/p4c/main/requirements.txt > requirements.txt
pip3 install --user -r requirements.txt

# Install docker and bmv2-switch container
## Using public container
#sudo docker pull davidjosearaujo/bmv2-switch
#sudo docker run --cap-add=NET_ADMIN --name testSwitch davidjosearaujo/bmv2-switch
## Using local image
cd docker/
sudo docker-compose build
sudo docker-compose up