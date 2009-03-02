# Build core system.

TOP = $(CURDIR)/..
include $(TOP)/COMMON

# By default install DNS and hosts support for name lookup -- these are
# dynamically loaded by the C library, so won't be picked up automatically.
EXTRA_LIBS ?= libnss_dns libnss_files

# By default don't bother with ldconfig at all.
LDCONFIG ?= none


INIT_D = $(CURDIR)/etc/init.d

populate_EXPORTS = \
    sysroot BINUTILS_DIR COMPILER_PREFIX TERMS install_list EXTRA_LIBS

pre-install:
	rm -f $(install_list)
	$(call EXPORT, sysroot) $(scripts)install-files '$(CURDIR)/file-list'
	$(first-time) '#!/bin/sh'

#	$(startup) $(INIT_D)/network S100
	$(startup) $(INIT_D)/network.mtd S100

	@$(useradd) -c 'root' -d /root -g 0 -u 0  -s /bin/sh \
            -p'$(ROOT_PASSWORD)' root
	$(useradd) -c 'daemon' -d /usr/sbin -g 1 -u 1 -s /bin/sh daemon
#	$(useradd) -c 'User' -d / -g 1 -u 10 -s /bin/sh -p '' user


post-install:
	$(call EXPORT,$(populate_EXPORTS)) $(scripts)populate
	$(call EXPORT, sysroot BINUTILS_DIR COMPILER_PREFIX) \
            $(scripts)ldconfig $(LDCONFIG)
	$(first-time) 'rm /etc/first-time.sh'
