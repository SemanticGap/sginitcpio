#!/bin/sh

mkdir /tmp/shutdown
mount -t tmpfs none /tmp/shutdown
cp -ra /run/initramfs/* /tmp/shutdown
cp /umount-overlay.sh /tmp/shutdown

#mount -o remount,ro  /run/overlay/rw

for i in dev sys run proc; do
  mount --move /$i /tmp/shutdown/$i
done

#exec chroot /run/initramfs ${1:-/shutdown}
cd /tmp/shutdown
mkdir oldroot
pivot_root . /tmp/shutdown/oldroot
echo Pivoted
exec /bin/sh
