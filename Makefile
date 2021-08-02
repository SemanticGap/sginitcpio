NAME=semgap-initcpio
VERSION=0.1

.PHONY: clean release install

clean:
	rm -r release

release:
	mkdir -p release/$(NAME)
	cp -r Makefile shutdown-hooks hooks install release/$(NAME)
	tar cvfz release/$(NAME)-$(VERSION).tar.gz -C release $(NAME)

install:
	install -d $(DESTDIR)/usr/lib/initcpio
	install -d $(DESTDIR)/usr/lib/initcpio/hooks
	install -d $(DESTDIR)/usr/lib/initcpio/install
	install hooks/overlay $(DESTDIR)/usr/lib/initcpio/hooks/overlay
	install install/overlay $(DESTDIR)/usr/lib/initcpio/install/overlay
	install install/fs-extra $(DESTDIR)/usr/lib/initcpio/install/fs-extra
	install hooks/livecd $(DESTDIR)/usr/lib/initcpio/hooks/livecd
	install install/livecd $(DESTDIR)/usr/lib/initcpio/install/livecd
	install hooks/shutdown-hooks $(DESTDIR)/usr/lib/initcpio/hooks/shutdown-hooks
	install install/shutdown-hooks $(DESTDIR)/usr/lib/initcpio/install/shutdown-hooks
	install shutdown-hooks $(DESTDIR)/usr/lib/initcpio/shutdown-hooks

