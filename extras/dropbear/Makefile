TOP = $(CURDIR)/../..
include ../COMMON

MD5_SUM_0.51 = 95d900913bee4b27d7e9ce55f8a55427

PROGRAMS = dbclient dropbearkey dropbearconvert scp

# EXTRA_LIBS = libcrypt libutil     # May want to automatically use this

config: 
	cd $(srcdir)  &&  ./configure \
            --host=$(COMPILER_PREFIX) --disable-zlib --disable-openpty \
            --prefix=$(O)

build:
	make -C $(srcdir) PROGRAMS="dropbear $(PROGRAMS)" MULTI=1

install:
	$(install) $(sysroot)/sbin $(srcdir)/dropbearmulti
	chmod g+s,u+s $(sysroot)/sbin/dropbearmulti
	ln -s /sbin/dropbearmulti $(sysroot)/sbin/dropbear
	for program in $(PROGRAMS); do \
            ln -s /sbin/dropbearmulti $(sysroot)/bin/$$program; \
        done


include ../RULES
