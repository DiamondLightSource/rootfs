TOP = $(CURDIR)/../..
include $(CURDIR)/../COMMON
include $(CURDIR)/../EXTRAS

nologin_VERSION = local

VPATH := $(CURDIR)

config: 
	mkdir -p $(O)

build:
	make -C $(O) CURDIR=$(CURDIR) -f $(CURDIR)/Makefile do-build

do-build: nologin

install:
	$(install) -m 555 $(O)/nologin /sbin




include $(CURDIR)/../RULES
