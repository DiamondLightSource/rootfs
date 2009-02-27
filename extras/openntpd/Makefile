TOP = $(CURDIR)/../..
include ../COMMON

openntpd_VERSION ?= 3.9p1

TAR_EXTENSION = .tar.gz
MD5_SUM_3.9p1 = afc34175f38d08867c1403d9008600b3

OPENNTPD_UID ?= 101
OPENNTPD_GID ?= 101

NTPD_CONF ?= $(CURDIR)/ntpd.conf


config:
	cd $(O)  &&  \
        $(srcdir)/configure CFLAGS='$(CFLAGS)' \
            --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE) \
            --prefix=/

build:
	make -C $(O)

install:
	mkdir -m 755 -p $(sysroot)/var/empty/ntp
	$(groupadd) -g $(OPENNTPD_GID) _ntp
	$(useradd) -u $(OPENNTPD_UID) -g $(OPENNTPD_GID) \
            -c 'OpenNTP daemon' -d /var/empty/ntp -s /sbin/nologin _ntp

	$(install) -m 555 $(O)/ntpd /sbin
	$(install) $(NTPD_CONF) /etc

	$(startup) $(CURDIR)/openntpd S210


include ../RULES
