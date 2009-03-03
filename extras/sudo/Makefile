TOP = $(CURDIR)/../..
include ../COMMON

sudo_VERSION ?= 1.6.9p17

TAR_EXTENSION = .tar.gz
MD5_SUM_1.6.9p17 = 60daf18f28e2c1eb7641c4408e244110

PATCHES_1.6.9p17 = cross-compile-1.6.9p17.patch


config:
	cd $(O)  &&  \
        $(srcdir)/configure CFLAGS='$(CFLAGS)' \
            --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE) \
            --without-pam --with-editor=/bin/vi

build:
	make -C $(O)

install:
	$(install) -s -m a=rx,u+s,g+s $(O)/sudo /usr/bin
	$(install) -s -m a=rx,u+s,g+s $(O)/visudo /usr/bin

ifeq ($(SUDOERS_FILE),)
	$(install) -f -m ug=r /dev/null /etc/sudoers
else
	$(install) -f -m ug=r $(SUDOERS_FILE) /etc/sudoers
endif


include ../RULES
