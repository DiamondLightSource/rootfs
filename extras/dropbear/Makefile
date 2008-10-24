TOP = $(CURDIR)/../..
include ../COMMON

MD5_SUM_0.51 = 95d900913bee4b27d7e9ce55f8a55427

PROGRAMS = dbclient dropbearkey dropbearconvert scp
INETD_CONF = 22 stream tcp nowait root /sbin/dropbearmulti dropbear -i


# May want to automatically use this
# EXTRA_LIBS = libcrypt libutil libnss_compat libnsl libnss_nis libnss_files

config: 
	cd $(srcdir)  &&  ./configure \
            --host=$(COMPILER_PREFIX) --disable-zlib --disable-lastlog \
            --disable-largefile --disable-shadow \
            --prefix=$(O)
	make -C $(srcdir) clean

build:
	make -C $(srcdir) PROGRAMS="dropbear $(PROGRAMS)" \
            MULTI=1 SCPPROGRESS=1

# Normal installation
install: install-root
	$(install) $(sysroot)/sbin $(srcdir)/dropbearmulti
	chmod g+s,u+s $(sysroot)/sbin/dropbearmulti
	ln -s /sbin/dropbearmulti $(sysroot)/sbin/dropbear
	for program in $(PROGRAMS); do \
            ln -s /sbin/dropbearmulti $(sysroot)/bin/$$program; \
        done

# Extra installation of configuration settings
install-root:
	echo '$(INETD_CONF)' >$(sysroot)/etc/inetd.conf
	mkdir $(sysroot)/root/.ssh $(sysroot)/etc/dropbear
	chmod 700 $(sysroot)/root/.ssh
ifdef SSH_AUTHORIZED_KEYS
	install -m 700 $(SSH_AUTHORIZED_KEYS) \
            $(sysroot)/root/.ssh/authorized_keys
endif
	for file in $(CURDIR)/dropbear/*; do \
            install -m 700 $$file $(sysroot)/etc/dropbear; \
        done

# The following commands are needed to build the dropbear machine keys:
# dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
# dropbearkey -t dsa -f /etc/dropbear/dropbear_dsa_host_key


include ../RULES
