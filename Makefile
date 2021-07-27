NAME=semgap-initcpio
VERSION=0.1

.PHONY: clean release install

clean:
	rm -r release

release:
	mkdir -p release/$(NAME)
	cp -r Makefile hooks install shutdown.d release/$(NAME)
	tar cvfz release/$(NAME)-$(VERSION).tar.gz -C release $(NAME)

install:
	install -d $(DESTDIR)/usr/lib/initcpio
	install -d $(DESTDIR)/usr/lib/initcpio/hooks
	install hooks/overlay $(DESTDIR)/usr/lib/initcpio/hooks/overlay
	install hooks/livecd $(DESTDIR)/usr/lib/initcpio/hooks/livecd
	install -d $(DESTDIR)/usr/lib/initcpio/install
	install install/overlay $(DESTDIR)/usr/lib/initcpio/install/overlay
	install install/fs-extra $(DESTDIR)/usr/lib/initcpio/install/fs-extra
	install install/livecd $(DESTDIR)/usr/lib/initcpio/install/livecd
	install -d $(DESTDIR)/usr/lib/initcpio/shutdown.d
	install shutdown.d/overlay $(DESTDIR)/usr/lib/initcpio/shutdown.d/overlay

