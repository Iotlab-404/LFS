ps 
ln -sv /lib/libprocps.so.4 /usr/lib/libprocps.so.4
ps 
free
ln -sv /lib/libprocps.so.4 /usr/local/libprocps.so.4
free
ldconfig -v
ldconfig -v|grep "No such file or directory"
ldconfig -v|grep "libprocps.so.4"
ln -sv /lib/libprocps.so.4 /tools/lib/libprocps.so.4
free
ps
top
clear
cd ../e2fsprogs-1.42.12
sed -e '/int.*old_desc_blocks/s/int/blk64_t/'     -e '/if (old_desc_blocks/s/super->s_first_meta_bg/desc_blocks/'     -i lib/ext2fs/closefs.c
mkdir -v build
cd build
LIBS=-L/tools/lib                    CFLAGS=-I/tools/include              PKG_CONFIG_PATH=/tools/lib/pkgconfig ../configure --prefix=/usr                        --bindir=/bin                        --with-root-prefix=""                --enable-elf-shlibs                  --disable-libblkid                   --disable-libuuid                    --disable-uuidd                      --disable-fsck
make
ln -sfv /tools/lib/lib{blk,uu}id.so.1 lib
make LD_LIBRARY_PATH=/tools/lib check
make install
make install-libs
chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info
makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
install -v -m644 doc/com_err.info /usr/share/info
install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
e2fsck -v
find / -name libext2fs.so.2
ln -sv /lib/libext2fs.so.2 /tools/lib/libext2fs.so.2
e2fsck -v
ln -sv /lib/libcom_err.so.2 /tools/lib/libcom_err.so.2
e2fsck -v
ln -sv /lib/libe2p.so.2 /tools/lib/libe2p.so.2
e2fsck -v
clear
cd ../../coreutils-8.23
patch -Np1 -i ../coreutils-8.23-i18n-1.patch 
touch Makefile.in
FORCE_UNSAFE_CONFIGURE=1 ./configure             --prefix=/usr                        --enable-no-install-program=kill,uptime
make
make
make install
ln -sv /lib/libattr.so.1 /tools/lib/libattr.so.1
make install
mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8
cp -v
mv -v /usr/bin/{head,sleep,nice,test,[} /bin
mv -v
cd ../iana-etc-2.30
make
make install
cd ../m4-1.4.17
./configure --prefix=/usr
find / -name libgmp.so.10
ln -sv /usr/lib/libgmp.so.10 /tools/lib/libgmp.so.10
./configure --prefix=/usr
ln -sv /lib/libcap.so.2 /tools/lib/libcap.sl.2
./configure --prefix=/usr
ln -sv /lib/libcap.so.2 /tools/lib/libcap.so.2
rm /tools/lib/libcap.sl.2
./configure --prefix=/usr
printenv 
make
make install
cd ../flex-2.5.39
sed -i -e '/test-bison/d' tests/Makefile.in
./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.5.39
make
make install
ln -sv flex /usr/bin/lex
cd ../bison-3.0.4
./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.0.4
make
make install
cd ../grep-2.21
sed -i -e '/tp++/a  if (ep <= tp) break;' src/kwset.c
./configure --prefix=/usr --bindir=/bin ; make ; make install
cd ../readline-6.3
patch -Np1 -i ../readline-6.3-upstream_fixes-3.patch
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install
./configure --prefix=/usr --docdir=/usr/share/doc/readline-6.3;make SHLIB_LIBS=-lncurses;make SHLIB_LIBS=-lncurses install;
mv -v /usr/lib/lib{readline,history}.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) /usr/lib/libhistory.so
install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-6.3
cd ../bash-4.3.30
patch -Np1 -i ../bash-4.3.30-upstream_fixes-1.patch
./configure --prefix=/usr                                   --bindir=/bin                                   --docdir=/usr/share/doc/bash-4.3.30             --without-bash-malloc                           --with-installed-readline;make;make install;
exec /bin/bash --login +h
cd ../bc-1.06.95
patch -Np1 -i ../bc-1.06.95-memory_leak-1.patch
./configure --prefix=/usr                       --with-readline                     --mandir=/usr/share/man             --infodir=/usr/share/info;make;make install;
cd ../libtool-2.4.6
./configure --prefix=/usr;make;make install
cd ../gdbm-1.11
./configure --prefix=/usr --enable-libgdbm-compat;make;make install
cd ../expat-2.1.0
./configure --prefix=/usr;make;make install;install -v -dm755 /usr/share/doc/expat-2.1.0;install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.1.0
cd ../inetutils-1.9.2
echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h 
./configure --prefix=/usr                    --localstatedir=/var             --disable-logger                 --disable-whois                  --disable-servers;make;make install
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin
cd ../perl-5.20.2
echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
export BUILD_ZLIB=False
export BUILD_BZIP2=0
sh Configure -des -Dprefix=/usr                                   -Dvendorprefix=/usr                             -Dman1dir=/usr/share/man/man1                   -Dman3dir=/usr/share/man/man3                   -Dpager="/usr/bin/less -isR"  \
sh Configure -des -Dprefix=/usr                                   -Dvendorprefix=/usr                             -Dman1dir=/usr/share/man/man1                   -Dman3dir=/usr/share/man/man3                   -Dpager="/usr/bin/less -isR"  \
sh Configure -des -Dprefix=/usr                                   -Dvendorprefix=/usr                             -Dman1dir=/usr/share/man/man1                   -Dman3dir=/usr/share/man/man3                   -Dpager="/usr/bin/less -isR"                    -Duseshrplib;make;make -k test;make install ;unset BUILD_ZLIB BUILD_BZIP2;
sh Configure -des -Dprefix=/usr                                   -Dvendorprefix=/usr                             -Dman1dir=/usr/share/man/man1                   -Dman3dir=/usr/share/man/man3                   -Dpager="/usr/bin/less -isR"                    -Duseshrplib
df -lh
make
find / -name libgdbm.so.4
ln -sv /usr/lib/libgdbm.so.4 /tools/lib/libgdbm.so.4
sh Configure -des -Dprefix=/usr                                   -Dvendorprefix=/usr                             -Dman1dir=/usr/share/man/man1                   -Dman3dir=/usr/share/man/man3                   -Dpager="/usr/bin/less -isR"                    -Duseshrplib
ln -sv /usr/lib/libgdbm_compat.so.4 /tools/lib/libgdbm_compat.so.4
sh Configure -des -Dprefix=/usr                                   -Dvendorprefix=/usr                             -Dman1dir=/usr/share/man/man1                   -Dman3dir=/usr/share/man/man3                   -Dpager="/usr/bin/less -isR"                    -Duseshrplib
make ; make -k test; make install;unset BUILD_ZLIB BUILD_BZIP2;
cd ../XML-Parser-2.44
perl Makefile.PL;make;make install
cd ../autoconf-2.69
./configure --prefix=/usr;make;make install
cd ../automake-1.15
./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.15
make
sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh
make -j4 check
make install
cd ../diffutils-3.3
sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in
./configure --prefix=/usr;make;make install;
cd ../gawk-4.1.1
./configure --prefix=/usr;make;make install;
mkdir -v /usr/share/doc/gawk-4.1.1
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.1.1
awk -v
find / -name libmpfr.so.4
ln -sv /usr/lib/libmpfr.so.4 /tools/lib/libmpfr.so.4
awk -v
cd ../findutils-4.4.2
./configure --prefix=/usr --localstatedir=/var/lib/locate;make;make install;mv -v /usr/bin/find /bin;sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb;
find -v
find -h
find --help
whereis find
cd ../gettext-0.19.4
./configure --prefix=/usr --docdir=/usr/share/doc/gettext-0.19.4;make;make install
cd ../intltool-0.50.2
./configure --prefix=/usr;make;make install;install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.50.2/I18N-HOWTO;
cd ../gperf-3.0.4
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.0.4;make;make install
cd ../groff-1.22.3
PAGE=A4 ./configure --prefix=/usr;make ;make install
cd ../xz-5.2.0
./configure --prefix=/usr --docdir=/usr/share/doc/xz-5.2.0;make;make install;mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv -v /usr/lib/liblzma.so.* /lib
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so
cd ../grub-2.02~beta2
./configure --prefix=/usr                      --sbindir=/sbin                    --sysconfdir=/etc                  --disable-grub-emu-usb             --disable-efiemu                   --disable-werror;make;make install
cd ../less-458
./configure --prefix=/usr --sysconfdir=/etc;make;make install
cd ../gzip-1.6
./configure --prefix=/usr --bindir=/bin;make;make install;mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin;mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin
cd ../iproute2-3.19.0
sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile
make ;make DOCDIR=/usr/share/doc/iproute2-3.19.0 install;
ip
cd ../kbd-2.0.2
patch -Np1 -i ../kbd-2.0.2-backspace-1.patch
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
make ;make install
make;make install
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock;make;make install
mkdir -v       /usr/share/doc/kbd-2.0.2
cp -R -v docs/doc/* /usr/share/doc/kbd-2.0.2
cd ../kmod-19
./configure --prefix=/usr                      --bindir=/bin                      --sysconfdir=/etc                  --with-rootlibdir=/lib             --with-xz                          --with-zlib;make;make install;
for target in depmod insmod lsmod modinfo modprobe rmmod; do   ln -sv ../bin/kmod /sbin/$target; done
ln -sv kmod /bin/lsmod
cd ../libpipeline-1.4.0
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr;make ;make install;
cd ../make-4.1
./configure --prefix=/usr;make;make install;
cd ../patch-2.7.4
./configure --prefix=/usr;make;make install;
cd ../systemd-219
cat > config.cache << "EOF"
KILL=/bin/kill
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include/blkid"
HAVE_LIBMOUNT=1
MOUNT_LIBS="-lmount"
MOUNT_CFLAGS="-I/tools/include/libmount"
cc_cv_CFLAGS__flto=no
EOF

tar zxvf mpc-1.0.2.tar.grep -rl "blkid/blkid.h" 
sed -i "s:grep -rl "blkid/blkid.h"
;
cat > config.cache << "EOF"
KILL=/bin/kill
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include/blkid"
HAVE_LIBMOUNT=1
MOUNT_LIBS="-lmount"
MOUNT_CFLAGS="-I/tools/include/libmount"
cc_cv_CFLAGS__flto=no
EOF

sed -i "s:blkid/::" $(grep -rl "blkid/blkid.h")
patch -Np1 -i ../systemd-219-compat-1.patch
sed -i "s:test/udev-test.pl ::g" Makefile.in
./configure --prefix=/usr                                                       --sysconfdir=/etc                                                   --localstatedir=/var                                                --config-cache                                                      --with-rootprefix=                                                  --with-rootlibdir=/lib                                              --enable-split-usr                                                  --disable-gudev                                                     --disable-firstboot                                                 --disable-ldconfig                                                  --disable-sysusers                                                  --without-python                                                    --docdir=/usr/share/doc/systemd-219                                 --with-dbuspolicydir=/etc/dbus-1/system.d                           --with-dbussessionservicedir=/usr/share/dbus-1/services             --with-dbussystemservicedir=/usr/share/dbus-1/system-services;make LIBRARY_PATH=/tools/lib;make LD_LIBRARY_PATH=/tools/lib install;mv -v /usr/lib/libnss_{myhostname,mymachines,resolve}.so.2 /lib;rm -rfv /usr/lib/rpm;
find / -name libgettextsrc-0.19.4.so:
find / -name libgettextsrc-0.19.4.so
ln -sv /usr/lib/libgettextsrc-0.19.4.so /tools/lib/libgettextsrc-0.19.4.so
./configure --prefix=/usr                                                       --sysconfdir=/etc                                                   --localstatedir=/var                                                --config-cache                                                      --with-rootprefix=                                                  --with-rootlibdir=/lib                                              --enable-split-usr                                                  --disable-gudev                                                     --disable-firstboot                                                 --disable-ldconfig                                                  --disable-sysusers                                                  --without-python                                                    --docdir=/usr/share/doc/systemd-219                                 --with-dbuspolicydir=/etc/dbus-1/system.d                           --with-dbussessionservicedir=/usr/share/dbus-1/services             --with-dbussystemservicedir=/usr/share/dbus-1/system-services;make LIBRARY_PATH=/tools/lib;make LD_LIBRARY_PATH=/tools/lib install;mv -v /usr/lib/libnss_{myhostname,mymachines,resolve}.so.2 /lib;rm -rfv /usr/lib/rpm;
ln -sv /usr/lib/libgettextlib-0.19.4.so /tools/lib/libgettextlib-0.19.4.so
./configure --prefix=/usr                                                       --sysconfdir=/etc                                                   --localstatedir=/var                                                --config-cache                                                      --with-rootprefix=                                                  --with-rootlibdir=/lib                                              --enable-split-usr                                                  --disable-gudev                                                     --disable-firstboot                                                 --disable-ldconfig                                                  --disable-sysusers                                                  --without-python                                                    --docdir=/usr/share/doc/systemd-219                                 --with-dbuspolicydir=/etc/dbus-1/system.d                           --with-dbussessionservicedir=/usr/share/dbus-1/services             --with-dbussystemservicedir=/usr/share/dbus-1/system-services;make LIBRARY_PATH=/tools/lib;make LD_LIBRARY_PATH=/tools/lib install;mv -v /usr/lib/libnss_{myhostname,mymachines,resolve}.so.2 /lib;rm -rfv /usr/lib/rpm;
find / -name libgomp.so.1
ln -sv /usr/lib/libgomp.so.1 /tools/lib/libgomp.so.1
./configure --prefix=/usr                                                       --sysconfdir=/etc                                                   --localstatedir=/var                                                --config-cache                                                      --with-rootprefix=                                                  --with-rootlibdir=/lib                                              --enable-split-usr                                                  --disable-gudev                                                     --disable-firstboot                                                 --disable-ldconfig                                                  --disable-sysusers                                                  --without-python                                                    --docdir=/usr/share/doc/systemd-219                                 --with-dbuspolicydir=/etc/dbus-1/system.d                           --with-dbussessionservicedir=/usr/share/dbus-1/services             --with-dbussystemservicedir=/usr/share/dbus-1/system-services;make LIBRARY_PATH=/tools/lib;make LD_LIBRARY_PATH=/tools/lib install;mv -v /usr/lib/libnss_{myhostname,mymachines,resolve}.so.2 /lib;rm -rfv /usr/lib/rpm;
for tool in runlevel reboot shutdown poweroff halt telinit; do      ln -sfv ../bin/systemctl /sbin/${tool}; done
ln -sfv ../lib/systemd/systemd /sbin/init
sed -i "s:0775 root lock:0755 root root:g" /usr/lib/tmpfiles.d/legacy.conf
sed -i "/pam.d/d" /usr/lib/tmpfiles.d/etc.conf
systemd-machine-id-setup
sed -i "s:minix:ext4:g" src/test/test-path-util.c
make LD_LIBRARY_PATH=/tools/lib -k check
cd ../dbus-1.8.16
./configure --prefix=/usr                                   --sysconfdir=/etc                               --localstatedir=/var                            --docdir=/usr/share/doc/dbus-1.8.16             --with-console-auth-dir=/run/console;make;make install
mv -v /usr/lib/libdbus-1.so.* /lib
rm /readlink /usr/lib/libdbus-1.so /usr/lib/libdbus-1.so
ln -sfv /etc/machine-id /var/lib/dbus
cd ../util-linux-2.26
mkdir -pv /var/lib/hwclock
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime               --docdir=/usr/share/doc/util-linux-2.26             --disable-chfn-chsh              --disable-login                  --disable-nologin                --disable-su                     --disable-setpriv                --disable-runuser                --disable-pylibmount             --without-python;make;make install
cd ../man-db-2.7.1
./configure --prefix=/usr                                    --docdir=/usr/share/doc/man-db-2.7.1             --sysconfdir=/etc                                --disable-setuid                                 --with-browser=/usr/bin/lynx                     --with-vgrind=/usr/bin/vgrind                    --with-grap=/usr/bin/grap;make;make install;sed -i "s:man root:root root:g" /usr/lib/tmpfiles.d/man-db.conf
cd ../tar-1.28
FORCE_UNSAFE_CONFIGURE=1  ./configure --prefix=/usr             --bindir=/bin;make;make install;make -C doc install-html docdir=/usr/share/doc/tar-1.28
make 
make clean
make
whereis tar
rmt -v
rmt -h
ls
cd ../
rm -rf tar-1.28
tar xvf tar-1.28.tar.xz 
cd tar-1.28
ls
FORCE_UNSAFE_CONFIGURE=1  ./configure --prefix=/usr             --bindir=/bin
make
ls
find ./ -name rmt
cp /tools/bin/tar /usr/bin/
cd ../texinfo-5.2
./configure --prefix=/usr;make;make install
make TEXMF=/usr/share/texmf install-tex
pushd /usr/share/info
rm -v dir
for f in *;   do install-info $f dir 2>/dev/null; done
popd
cd ../vim74/
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr;make;make install
ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do     ln -sv vim.1 $(dirname $L)/vi.1; done
ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do     ln -sv vim.1 $(dirname $L)/vi.1; done
ln -sv ../vim/vim74/doc /usr/share/doc/vim-7.4
cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF

vim -c ':options'
vim
find / -name vim
make
make clean
./configure --prefix=/usr
tar -v
find / -name iconv
/tools/bin/iconv -v
/tools/bin/iconv --help
find / -name libiconv
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH // 
find / -name iconv
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
./configure --prefix=/usr
which iconv
export LD_LIBRARY_PATH=/usr/lib/:$LD_LIBRARY_PATH
./configure --prefix=/usr
find / -name iconv
find / -name config.log
find ./ -name config.log
cat ./src/auto/config.log 
find ./ -name libnetcdf.so.7
find / -name iconv
/usr/bin/iconv -v
ldd /usr/bin/iconv 
./configure --prefix=/usr
export LD_LIBRARY_PATH=/tools/lib/:$LD_LIBRARY_PATH
./configure --prefix=/usr
find / -name iconv
echo $LD_LIBRARY_PATH
find / -name ld-linux-x86-64.so.2
find / -name libiconv
find / -name "*iconv*"
find / -name libiconv.so.2
cd ..
ls
mkdir self
cd self/
cd ..
ls -la vim-7.4.tar.bz2 
ls
cd self/
ls
ls
tar jxvf vim-7.1.tar.bz2 
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
ls
cd vim71/
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr
make
cd ..
ls
rm -rf vim*
ls
cd ..
ls
cd self/
ls
cd ..
ls
mv vim-6.0.tar.bz2 ./self/
cd self/
tar jxvf vim-6.0.tar.bz2 
df -lh
cd vim60/
ls
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr
make
ls
cd ..
ls
rm -rf vim-6.0.tar.bz2  vim60/ 
tar jxvf vim-8.0.tar.bz2 
cd vim80/
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr
ls
cd ..
ls
rm vim* -rf
ls
tar jxvf vim-8.0.tar.bz2 
ls
cd vim
cd vim80/
echo '#define SYS_VIMRC_FILE  "/etc/vimrc"' >>  src/feature.h && echo '#define SYS_GVIMRC_FILE "/etc/gvimrc"' >> src/feature.h && ./configure --prefix=/usr             --with-features=huge             --with-tlib=ncursesw && make
cd ..
ls
tar xvf nano-2.8.3.tar.xz 
cd nano-2.8.3
ls
./configure --prefix=/usr --disable-spell
./configure --prefix=/usr                 --sysconfdir=/etc             --enable-utf8                 --docdir=/usr/share/doc/nano-2.8.3
make
make install && install -v -m644 doc/nano.html /usr/share/doc/nano-2.8.3
nano /etc/nanorc 
find / -name libz.so.1
ln -sv /lib/libz.so.1 /tools/lib/libz.so.1
nano /etc/nanorc 
logout
ls
cd sources/
ls
tar zxvf pkg-config-0.28.tar.gz 
df -lh
tar zxvf ncurses-5.9.tar.gz 
ls
tar zxvf attr-2.4.47.src.tar.gz 
tar xzvf acl-2.2.52.src.tar.gz 
tar xvf libcap-2.24.tar.xz 
tar xjvf sed-4.2.2.tar.bz2 
tar jxvf sed-4.2.2.tar.bz2 
whereis tar
/tools/bin/tar xjvf sed-4.2.2.tar.bz2 
find / -name libbz2.so
find / -name libbz2.so.1.0
ldconfig 
ldconfig 

tar jxvf sed-4.2.2.tar.bz2 
ldd bzip2
ldd ./bin/bzip2
whereis bzip2
/bin/bzip2
/tools/bin/bzip2
cp /tools/bin/bzip2 /bin/
tar jxvf sed-4.2.2.tar.bz2 
tar xvf shadow-4.2.1.tar.xz 
tar xzvf psmisc-22.21.tar.gz 
tar xvf procps-ng-3.3.10.tar.xz 
df -lh
df -lhclear
clear
tar xzvf e2fsprogs-1.42.12.tar.gz 
tar xvf coreutils-8.23.tar.xz 
df -lh
df -lh
whoami 
tar xjvf iana-etc-2.30.tar.bz2 
tar xvf m4-1.4.17.tar.xz 
tar xvjf flex-2.5.39.tar.bz2 
tar xvf bison-3.0.4.tar.xz 
tar xvf grep-2.21.tar.xz 
tar xzvf readline-6.3.tar.gz 
tar zxvf bash-4.3.30.tar.gz 
tar xjvf bc-1.06.95.tar.bz2 
tar xvf libtool-2.4.6.tar.xz 
tar zxvf gdbm-1.11.tar.gz 
tar zxvf expat-2.1.0.tar.gz 
tar zxvf inetutils-1.9.2.tar.gz 
tar xvjf perl-5.20.2.tar.bz2 
tar zxvf XML-Parser-2.44.tar.gz 
tar xvf autoconf-2.69.tar.xz 
tar xvf automake-1.15.tar.xz 
tar xvf diffutils-3.3.tar.xz 
df -lh
ls
mount
tar xvf gawk-4.1.1.tar.xz 
tar xvzf findutils-4.4.2.tar.gz 
tar xvf gettext-0.19.4.tar.xz 
tar xzvf intltool-0.50.2.tar.gz 
tar xzvf gperf-3.0.4.tar.gz 
tar xzvf intltool-0.50.2.tar.gz 
tar xzvf gperf-3.0.4.tar.gz 
tar xzvf groff-1.22.3.tar.gz 
tar xvf xz-5.2.0.tar.xz 
tar xvf grub-2.02~beta2.tar.xz 
tar zxvf less-458.tar.gz 
tar zxvf gzip-1.6.tar.xz 
tar xvf gzip-1.6.tar.xz 
tar xvf iproute2-3.19.0.tar.xz 
tar zxvf kmod-19.tar.xz 
tar xvf kmod-19.tar.xz 
tar zxvf libpipeline-1.4.0.tar.gz 
tar jxvf make-4.1.tar.bz2 
tar xvf patch-2.7.4.tar.xz 
tar xvf systemd-219.tar.xz 
tar zxvf dbus-1.8.16.tar.gz 
tar xvf util-linux-2.26.tar.xz 
tar xvf man-db-2.7.1.tar.xz 
tar xvf tar-1.28.tar.xz 
tar xvf texinfo-5.2.tar.xz 
tar xjvf vim-7.4.tar.bz2 
whereis findutils-4.4.2
whereis find
df -lh
ls
cd ..
ls
logout
/tools/bin/find /{,usr/}{bin,lib,sbin} -type f     -exec /tools/bin/strip --strip-debug '{}' ';'
logout
rm -rf /tmp/*
logout
