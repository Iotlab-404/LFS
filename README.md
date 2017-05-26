# LFS搭建

> 建立此项目的主要目的是为了备份文件系统环境，因为某些软件在`make install`之后会大幅度地改变环境配置，可能会影响整体，遂备份于此．(鉴于Github不能上传大于50M的文件,所以去掉了某些文件)


参考:[https://linux.cn/lfs/LFS-BOOK-7.7-systemd/index.html](https://linux.cn/lfs/LFS-BOOK-7.7-systemd/index.html)

------------------

##  issue
* 若发现`./configure`或`make`或`make install`过程中出现缺少某个libxxx.so文件，大都是因为其路径不在动态加载库的搜索路径中．然我发现改变`/etc/ld.so.conf`同时执行`/sbin/ldconfig`也无济于事．在LFS搭建前文以及[这里](http://www.cnblogs.com/sukai/p/3669330.html)在`/tools/lib/`目录下建立软链接即可解决问题．我首先遇到的是在第六章安装gcc的时候发现这个问题，而后借助搜索引擎．同时执行某些二进制文件的时候也会报这个错，因此`make check`还是很有用的，虽然很占用SBU，但是可以发现缺少哪些库，尽早解决问题．


* 在安装coreutils的时候make之后报错，参照[这里](http://albertcn.lofter.com/post/1cc8556c_665b22a)在Makefile文件增加一串字符即可解决问题．

* grub引导的时候可以借助已有的宿主Linux环境直接在`/boot/grub/grub.cfg`增加启动项，由于我是boot分区重新挂载的，因此按照教程稍微更改以下配置,sda10为boot分区所在的Linux内核分区，sda11为根文件系统．具体如下：
```bash
###LFS START

insmod ext2
set root=(hd0,10)

menuentry "GNU/Linux, Linux 3.19-lfs-7.7-systemd" {
	        linux   /vmlinuz-3.19-lfs-7.7-systemd root=/dev/sda11 ro
}



###LFS END

```

* /etc/fstab详情如下：
```bash
# Begin /etc/fstab

# 文件系统  挂载点  文件类型     挂载选项             dump  fsck
#                                                              order

/dev/sda11     /            ext4    defaults            1     1
/dev/sda6      swap         swap     pri=1               0     0
proc           /proc        proc     nosuid,noexec,nodev 0     0
sysfs          /sys         sysfs    nosuid,noexec,nodev 0     0
devpts         /dev/pts     devpts   gid=5,mode=620      0     0
tmpfs          /run         tmpfs    defaults            0     0
devtmpfs       /dev         devtmpfs mode=0755,nosuid    0     0
/dev/sda15     /usr         ext4    defaults           1        2
/dev/sda16     /home   		ext4    defaults            1       2 
/dev/sda10	   /boot        ext4    defaults            1      2
/dev/cdrom	/media/cdrom	auto	ro,noauto,user,exec	0 0
/dev/fd0	/media/floppy	auto	rw,noauto,user,sync	0 0

# End /etc/fstab

```

* 系统boot之后会报错，主要是systemd的问题．首先我发现的问题init进程起不来，后来发现还是少了某些库文件．之后根据[这里](https://forums.gentoo.org/viewtopic-t-1026806-start-25.html)直接把init换成systemd进程，但reboot后发现网络时间有问题．由于LFS没有提供对网络驱动的支持，因此在认真阅读参考资料后去除掉相关配置，之后便可以成功启动．

## 下一步
* 网络支持和桌面化以及iso化...
