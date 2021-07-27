.PHONY: run all

test.initrd:
	sudo mkinitcpio -g test.initrd -A fs-extra -A livecd -A overlay -A shutdown -S autodetect

run:
	qemu-system-x86_64 -kernel /boot/vmlinuz-linux -initrd test.initrd -append 'livecd=cdrom overlay_root=/dev/sda console=tty0,ttyS0' -vnc :1 -cdrom livecd.iso -hdb overlay.img -serial stdio -m 512

all: overlay.img livecd.iso

tmp/livecd/livecd.squashfs: tmp/rootfs
	mkdir -p tmp/livecd
	sudo mksquashfs $< $@

tmp/rootfs:
	mkdir -p tmp/rootfs/bin
	mkdir -p tmp/rootfs/dev
	mkdir -p tmp/rootfs/proc
	ln -s bin tmp/rootfs/sbin
	mkdir -p tmp/rootfs/sys
	mkdir -p tmp/rootfs/run
	mkdir -p tmp/rootfs/tmp
	cp /usr/bin/busybox tmp/rootfs/bin
	ln -s busybox tmp/rootfs/bin/init
	ln -s busybox tmp/rootfs/bin/poweroff
	ln -s busybox tmp/rootfs/bin/reboot
	ln -s busybox tmp/rootfs/bin/sh

overlay.img:
	dd if=/dev/zero of=$@ bs=1M count=8
	mkfs.ext2 $@

livecd.iso: tmp/livecd/livecd.squashfs
	sudo mkisofs -o livecd.iso -J tmp/livecd
