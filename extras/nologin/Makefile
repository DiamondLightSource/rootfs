TOP = $(CURDIR)/../..
include ../COMMON
include ../EXTRAS

nologin_VERSION = local
TAR_FILE =


config: 
	mkdir -p $(O)
	ln -fs $(CURDIR)/nologin.c $(O)

build: $(O)nologin

install:
	$(install) -m 555 $(O)/nologin /sbin



include ../RULES
