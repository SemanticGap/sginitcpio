NAME=semgap-initcpio
VERSION=0.8

.PHONY: clean release install

all: release

clean:
	rm -r release

release:
	mkdir -p release/$(NAME)
	cp -r Makefile etc shutdown-hooks hooks install release/$(NAME)
	tar cvfz release/$(NAME)-$(VERSION).tar.gz --exclude-backups -C release $(NAME)

install:
	install -d $(DESTDIR)/usr/lib/initcpio
	install -d $(DESTDIR)/usr/lib/initcpio/hooks
	install -d $(DESTDIR)/usr/lib/initcpio/install
	install -m 0755 hooks/overlay $(DESTDIR)/usr/lib/initcpio/hooks/overlay
	install -m 0755 install/overlay $(DESTDIR)/usr/lib/initcpio/install/overlay
	install -m 0755 install/fs-extra $(DESTDIR)/usr/lib/initcpio/install/fs-extra
	install -m 0755 hooks/livecd $(DESTDIR)/usr/lib/initcpio/hooks/livecd
	install -m 0755 install/livecd $(DESTDIR)/usr/lib/initcpio/install/livecd
	install -m 0755 hooks/shutdown-hooks $(DESTDIR)/usr/lib/initcpio/hooks/shutdown-hooks
	install -m 0755 install/shutdown-hooks $(DESTDIR)/usr/lib/initcpio/install/shutdown-hooks
	install -m 0755 shutdown-hooks $(DESTDIR)/usr/lib/initcpio/shutdown-hooks
	install -d $(DESTDIR)/etc/mkinitcpio.d
	install -m 0644 etc/mkinitcpio.conf $(DESTDIR)/etc/mkinitcpio.conf.sg
	install -m 0644 etc/mkinitcpio.d/sglinux.preset $(DESTDIR)/etc/mkinitcpio.d/sglinux.preset
	install -m 0644 etc/mkinitcpio.d/sglinux-lts.preset $(DESTDIR)/etc/mkinitcpio.d/sglinux-lts.preset
	install -Dm 0644 etc/kernel/livecd-cmdline.conf $(DESTDIR)/etc/kernel/livecd-cmdline.conf
