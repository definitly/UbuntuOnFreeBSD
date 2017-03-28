#!/bin/sh

MASTER_SITES=http://de.archive.ubuntu.com/ubuntu/
UBUNTU_VERSION=(sed -n 1p config)
ARCH=(sed -n 2p config)
ubuntu=ubuntu_$UBUNTU_VERSION"_"$ARCH
tar=tar_$UBUNTU_VERSION"_"$ARCH
deb=deb_$UBUNTU_VERSION"_"$ARCH

if [ "$

