TOP = $(CURDIR)/../..
include ../COMMON

TAR_EXTENSION = .tar.gz
MD5_SUM_3.9p1 = afc34175f38d08867c1403d9008600b3

OPENNTPD_UID = 101
OPENNTPD_GID = 101


config: 
	mkdir -p $(O)
	make -C $(srcdir) distclean
	cd $(srcdir)  &&  ./configure --host=$(COMPILER_PREFIX) --prefix=/

build:
	make -C $(srcdir)

install:
	$(install) -m 555 $(srcdir)/ntpd /sbin
	echo '_ntp:x:$(OPENNTPD_UID):$(OPENNTPD_GID):OpenNTP daemon:/var/empty/ntp:/sbin/nologin' \
            >>$(sysroot)/etc/passwd
#	echo '_ntp::0:0:99999:7:::' >>$(sysroot)/etc/shadow
	echo '_npt:x:$(OPENNTPD_GID):' >>$(sysroot)/etc/group
	mkdir -m 755 -p $(sysroot)/var/empty/ntp
	$(install) $(CURDIR)/ntpd.conf /etc


include ../RULES
