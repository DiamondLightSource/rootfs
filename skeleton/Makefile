# Build core system.

TOP = $(CURDIR)/..
include $(TOP)/COMMON

INIT_D = $(CURDIR)/etc/init.d

install:
	$(scripts)install-files '$(sysroot)' '$(CURDIR)/file-list'
	$(startup) $(INIT_D)/makedevs S001
	$(startup) $(INIT_D)/syslogd S010
	$(startup) $(INIT_D)/network S100

	@$(useradd) -c 'root' -d /root -g 0 -u 0  -s /bin/sh \
            -p'$(ROOT_PASSWORD)' root
	$(useradd) -c 'daemon' -d /usr/sbin -g 1 -u 1 -s /bin/sh daemon
#	$(useradd) -c 'User' -d / -g 1 -u 10 -s /bin/sh -p '' user
