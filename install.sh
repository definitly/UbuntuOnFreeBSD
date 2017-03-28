#!/bin/sh

MASTER_SITES=http://de.archive.ubuntu.com/ubuntu/s
UBUNTU_VERSION=(sed -n 1p config)
ARCH=(sed -n 2p config)
ubuntu=ubuntu_$UBUNTU_VERSION"_"$ARCH
tar=tar_$UBUNTU_VERSION"_"$ARCH
deb=deb_$UBUNTU_VERSION"_"$ARCH

if ! [ "$ARCH" == "i386" -o "$ARCH" =="amd64" ]; then

 echo "Choose i386 or amd64"
    exit 1;
                 fi

if ! [ "$UBUNTU_VERSION"  == "14.04" -o "$UBUNTU_VERSION" == "16.10" ]; then

   echo "Choose 14.04 or 16.10"

          exit 1;
