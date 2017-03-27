MASTER_SITES=http://de.archive.ubuntu.com/ubuntu/
UBUNTU_VERSION=14.04
ARCH=i386
ubuntu=ubuntu_$UBUNTU_VERSION"_"$ARCH
tar=tar_$UBUNTU_VERSION"_"$ARCH
deb=deb_$UBUNTU_VERSION"_"$ARCH

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


         rm  -R         $ubuntu/boot $ubuntu/dev $ubuntu/etc/fonts $ubuntu/home   $ubuntu/root ubuntu/tmp \
                        $ubuntu/var/log  $ubuntu/var/tmp 
         mkdir -p       $ubuntu/var/run/shm



                      if ! [ -f "tar/libflashsupport.so" ];then 

                               cd tar && fetch ftp://ftp.tw.freebsd.org/pub/FreeBSD/FreeBSD/distfiles/flashplugin/9.0r48/libflashsupport.so && cd ../
   
                           fi

 
         cp tar/libflashsupport.so ubuntu/usr/lib

         ln -s bash ubuntu/bin/sh


                 cp /compat/linux/usr/lib/$(ls /compat/linux/usr/lib/ | grep libGL.so | head -3 | tail -n 1)       $ubuntu/usr/lib
                 cp /compat/linux/usr/lib/$(ls /compat/linux/usr/lib/ | grep libnvidia-glcore)                     $ubuntu/usr/lib
                 cp /compat/linux/usr/lib/$(ls /compat/linux/usr/lib/ | grep libnvidia-tls)                        $ubuntu/usr/lib
                 ln -s $(ls /compat/linux/usr/lib/ | grep libGL.so | head -3 | tail -n 1)                          $ubuntu/usr/lib/libGL.so.1

                   doas chroot $ubuntu /usr/lib/i386-linux-gnu/gdk-pixbuf-2.0/gdk-pixbuf-query-loaders \
                    > $ubuntu/usr/lib/i386-linux-gnu/gdk-pixbuf-2.0/2.10.0/loaders.cache


      doas cp -R $ubuntu /compat
      doas chroot /compat/$ubuntu /bin/dbus-uuidgen --ensure
