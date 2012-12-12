#!/bin/bash
#edit config files

echo "/dev/ada0p2		none		swap	sw		0		0" >> /mnt/etc/fstab
echo "/dev/ada1p2		none		swap	sw		0		0" >> /mnt/etc/fstab

echo 'zfs_enable="YES"' >> /mnt/etc/rc.conf

echo 'zfs_load="YES"' >> /mnt/boot/loader.conf
echo 'vfs.root.mountfrom="zfs:tank/root"' >> /mnt/boot/loader.conf

#export zpool
zpool export tank

#import zpool
zpool import -o altroot=/mnt -o cachefile=/tmp/zpool.cache tank

cp /tmp/zpool.cache /mnt/boot/zfs/

#show zpool
zpool get all tank

exit 0
