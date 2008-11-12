TOP = $(CURDIR)/../..
include ../COMMON

dropbear_VERSION ?= 0.51

MD5_SUM_0.51 = 95d900913bee4b27d7e9ce55f8a55427

PROGRAMS = dbclient dropbearkey dropbearconvert scp
INETD_CONF = ssh stream tcp nowait root /usr/sbin/dropbearmulti dropbear -i


# May want to automatically use this
# EXTRA_LIBS = libcrypt libutil libnss_compat libnsl libnss_nis libnss_files

config: 
	cd $(O)  &&  \
        $(srcdir)/configure CFLAGS='$(CFLAGS)' \
            --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE) \
            --disable-zlib --disable-lastlog --disable-largefile 

build:
	make -C $(O) PROGRAMS="dropbear $(PROGRAMS)" \
            MULTI=1 SCPPROGRESS=1

install: 
        # Normal installation (6555 = rx,u+s,g+s)
	$(install) -m 6555 $(O)/dropbearmulti /usr/sbin 
	ln -s /usr/sbin/dropbearmulti $(sysroot)/usr/sbin/dropbear
	for program in $(PROGRAMS) ssh; do \
            ln -s /usr/sbin/dropbearmulti $(sysroot)/usr/bin/$$program; \
        done

	echo '$(INETD_CONF)' >>$(sysroot)/etc/inetd.conf
	mkdir -m 700 $(sysroot)/root/.ssh $(sysroot)/etc/dropbear
ifdef SSH_AUTHORIZED_KEYS
	$(install) -m 644 $(SSH_AUTHORIZED_KEYS) /root/.ssh 
endif

ifdef DROPBEAR_KEYS
        # For development work we use a set of canned machine keys.
	$(install) -m600 $(CURDIR)/dropbear/* /etc/dropbear
else
        # For normal operation we generate the dropbear machine keys the
        # first time the target runs.
	$(first-time) \
            'dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key' \
            'dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key'
endif


include ../RULES
