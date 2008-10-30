TOP = $(CURDIR)/../..
include ../COMMON

dropbear_VERSION ?= 0.51

MD5_SUM_0.51 = 95d900913bee4b27d7e9ce55f8a55427

PROGRAMS = dbclient dropbearkey dropbearconvert scp
INETD_CONF = ssh stream tcp nowait root /usr/sbin/dropbearmulti dropbear -i


# May want to automatically use this
# EXTRA_LIBS = libcrypt libutil libnss_compat libnsl libnss_nis libnss_files

config: 
	mkdir -p $(O)
	cd $(O)  &&  \
        $(srcdir)/configure \
            --host=$(COMPILER_PREFIX) CFLAGS='$(CFLAGS)' \
            --disable-zlib --disable-lastlog --disable-largefile 

build:
	make -C $(O) PROGRAMS="dropbear $(PROGRAMS)" \
            MULTI=1 SCPPROGRESS=1

# Extra installation of configuration settings
install-root:
	echo '$(INETD_CONF)' >>$(sysroot)/etc/inetd.conf
	mkdir -m 700 $(sysroot)/root/.ssh $(sysroot)/etc/dropbear
ifdef SSH_AUTHORIZED_KEYS
	$(install) -m 644 $(SSH_AUTHORIZED_KEYS) /root/.ssh 
endif
	for file in $(CURDIR)/dropbear/*; do \
            $(install) -m 600 $$file /etc/dropbear; \
        done


install: install-root
        # Normal installation (6555 = rw,u+s,g+s)
	$(install) -m 6555 $(O)/dropbearmulti /usr/sbin 
	ln -s /usr/sbin/dropbearmulti $(sysroot)/usr/sbin/dropbear
	for program in $(PROGRAMS) ssh; do \
            ln -s /usr/sbin/dropbearmulti $(sysroot)/usr/bin/$$program; \
        done

# The following commands are needed to build the dropbear machine keys:
# dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
# dropbearkey -t dsa -f /etc/dropbear/dropbear_dsa_host_key


include ../RULES
