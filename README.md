# Working on full scripted install but for now follow below steps:
# 1) graphical install system
# 2) enter shell to partition
# 3) use script
# 4) exit shell and continue installation, "finish install", <Live CD> 

#edit config files

vi /mnt/etc/fstab
	/dev/ada0p2	none	swap	sw	0	0
	/dev/ada1p2	none	swap	sw	0	0

vi /mnt/etc/rc.conf
	zfs_enable="YES"

vi /mnt/boot/loader.conf
	zfs_load="YES"
	vfs.root.mountfrom="zfs:tank/root"

#export zpool
zpool export tank

#import zpool
zpool import -o altroot=/mnt -o cachefile=/tmp/zpool.cache tank

cp /tmp/zpool.cache /mnt/boot/zfs/

#show zpool
zpool get all tank

#reboot into BSD with ZFS and it's all set!
reboot
