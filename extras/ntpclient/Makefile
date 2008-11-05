TOP = $(CURDIR)/../..
include ../COMMON

ntpclient_VERSION ?= 2007_365

TAR_FILE = ntpclient_$(version).tar.gz
SOURCE_DIR_NAME = ntpclient-$(shell sed <<<'$(version)' 's/_.*//')

MD5_SUM_2007_365 = cb98711f11769cdd22fc592844cef414


build:
	CFLAGS='$(CFLAGS)' CC=$(COMPILER_PREFIX)-gcc VPATH=$(srcdir) \
            make -C $(O) -f $(srcdir)/Makefile


install:
	$(install) -m 555 $(O)/ntpclient /usr/bin 
#	$(startup) $(CURDIR)/ntpclient S210


include ../RULES
