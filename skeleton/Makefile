# Build core system.

TOP = $(CURDIR)/..
include $(TOP)/COMMON

# By default install DNS and hosts support for name lookup -- these are
# dynamically loaded by the C library, so won't be picked up automatically.
# Also want to install real time libraries as well.
EXTRA_LIBS ?= libnss_dns libnss_files librt libstdc++

# By default don't bother with ldconfig at all.
LDCONFIG ?= none


INIT_D = $(CURDIR)/etc/init.d
NW_EXPORTS = sysroot NW_HOSTNAME NW_ADDRESS NW_NETMASK NW_GATEWAY
populate_EXPORTS = \
    sysroot BINUTILS_DIR COMPILER_PREFIX TERMS install_list EXTRA_LIBS \
    LIB_PREFIX

pre-install:
	rm -f $(install_list)
	$(install-files) '$(CURDIR)/file-list'

        # Add target specific getty line to inittab
	echo '::respawn:/sbin/getty $(CONSOLE_BAUD) $(CONSOLE_TTY)' \
            >>$(sysroot)/etc/inittab

        # Configure networking according to selected mode
ifdef NETWORK
	$(call EXPORT, $(NW_EXPORTS)) $(CURDIR)/network $(NETWORK)
endif

	@$(useradd) -c 'root' -d /root -g 0 -u 0  -s /bin/sh \
            -p'$(ROOT_PASSWORD)' root
	$(useradd) -c 'daemon' -d /usr/sbin -g 1 -u 1 -s /bin/sh daemon
#	$(useradd) -c 'User' -d / -g 1 -u 10 -s /bin/sh -p '' user


post-install:
	$(call EXPORT,$(populate_EXPORTS)) $(scripts)populate
	$(call EXPORT, sysroot BINUTILS_DIR COMPILER_PREFIX) \
            $(scripts)ldconfig $(LDCONFIG)

	$(first-time) 'rm /etc/first-time.sh'
	$(first-time) 'mount -o remount,ro /'

