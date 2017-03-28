#!/bin/sh

MASTER_SITES=http://de.archive.ubuntu.com/ubuntu/
UBUNTU_VERSION=(sed -n 1p config)
ARCH=(sed -n 2p config)
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
         rm             $ubuntu/lib64/ld-linux-x86-64.so.2
         ln -s          ../lib/x86_64-linux-gnu/$(ls $ubuntu/lib/x86_64-linux-gnu | grep ld-2.)  $ubuntu/lib64/ld-linux-x86-64.so.2

                 if ! [ -f "$tar/libflashsupport.so" ];then 

                            cd $tar && fetch ftp://ftp.tw.freebsd.org/pub/FreeBSD/FreeBSD/distfiles/flashplugin/9.0r31/libflashsupport.so && cd ../
   
                       fi






                 
                if ! [ -f "$tar/NVIDIA-Linux-x86_64-375.26.run" ]; then 
                
                           cd $tar && fetch http://ru.download.nvidia.com/XFree86/Linux-x86_64/375.26/NVIDIA-Linux-x86_64-375.26.run
                           chmod +x NVIDIA-Linux-x86_64-375.26.run
                           cd ..
            
                       fi  

                cd $tar &&  ./NVIDIA-Linux-x86_64-375.26.run -x
                cd ..
                      cp    $tar/NVIDIA-Linux-x86_64-375.26/libGL.so.375.26                  $ubuntu/usr/lib/x86_64-linux-gnu
                      ln -s libGL.so.375.26                                                  $ubuntu/usr/lib/x86_64-linux-gnu/libGL.so.1
                      cp    $tar/NVIDIA-Linux-x86_64-375.26/libnvidia-tls.so.375.26          $ubuntu/usr/lib/x86_64-linux-gnu
                      cp    $tar/NVIDIA-Linux-x86_64-375.26/libnvidia-glcore.so.375.26       $ubuntu/usr/lib/x86_64-linux-gnu

 
               doas cp -R $ubuntu /compat/

