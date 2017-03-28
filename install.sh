#!/bin/sh

MASTER_SITES=http://de.archive.ubuntu.com/ubuntu/
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
                     fi

if ! [ -d  "$ubuntu"  ]; then

           mkdir -p  $ubuntu

       fi


if ! [ -d  "$deb"  ]; then

           mkdir -p  $deb

       fi

if ! [ -d  "$tar"  ]; then

           mkdir -p  $tar

       fi

                for BIN_DISTFILES in $(cat listpackages_$UBUNTU_VERSION"_"$ARCH);do

                        if ! [ -f $deb/$(echo  $BIN_DISTFILES | rev | sed -r 's/\/.+//' | rev) ]; then
         
                                 cd  $deb &&   fetch $MASTER_SITES$BIN_DISTFILES
                                 cd ../
 
                        fi 
                 done

   
                for DEB   in $(cat listpackages_$UBUNTU_VERSION"_"$ARCH); do
                   
                    deb2targz $deb/$(echo  $DEB | rev | sed -r 's/\/.+//' | rev)

                 done


                for TARGZ in $(cat listpackages_$UBUNTU_VERSION"_"$ARCH);do  

                    tar xf $deb/$(echo  $TARGZ  | rev | sed -r 's/\/.+//' | rev | sed s/.deb/.tar.*/) -C  $ubuntu 

                 done


         rm  -R         $ubuntu/boot $ubuntu/dev $ubuntu/etc/fonts $ubuntu/home   $ubuntu/root $ubuntu/tmp \
                        $ubuntu/var/log  $ubuntu/var/tmp 
         mkdir -p       $ubuntu/var/run/shm


      if [ "$ARCH" == "i386" ];then 

        else


            fi

      doas cp -R $ubuntu /compat
      doas chroot /compat/$ubuntu /bin/dbus-uuidgen --ensure
