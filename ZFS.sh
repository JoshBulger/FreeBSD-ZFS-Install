#!/bin/bash
for i in 0 1; do
        gpart destroy -F ada$i
        gpart create -s gpt ada$i
        gpart add -t freebsd-boot -s 128 ada$i
        gpart add -t freebsd-swap -s 4G ada$i
        gpart add -t freebsd-zfs -l disk0$i ada$i
        dd if=/dev/zero of=/dev/ada$ip2 count=560 bs=512
        gpart bootcode -b /boot/pmbr -p /boot/gptzfsboot -i 1 ada$i
done


zpool create -f -m none -o altroot=/mnt -o cachefile=/tmp/zpool.cache tank mirror gpt/disk00 gpt/disk01
zfs create -V 4G tank/swap
zfs set org.freebsd:swap=on tank/swap
        
zfs create -o mountpoint=/ tank/root
zfs create -o mountpoint=/usr tank/usr
zfs create -o mountpoint=/usr/home tank/usr/home
zfs create -o mountpoint=/var tank/var
zfs create -o mountpoint=/svr tank/svr
zfs create -o mountpoint=/tmp tank/tmp
zfs create -o mountpoint=/jail tank/jail


zpool set bootfs=tank/root tank


zpool get all tank
return 0