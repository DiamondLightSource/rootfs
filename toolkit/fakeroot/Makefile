TOP = $(CURDIR)/../..
include ../COMMON

# Project and download directories for fakeroot:
#   http://fakeroot.alioth.debian.org/
#   http://alioth.debian.org/projects/fakeroot/
#   http://ftp.de.debian.org/debian/pool/main/f/fakeroot/

fakeroot_VERSION ?= 1.11

TAR_FILE = fakeroot_$(version).tar.gz
MD5_SUM_1.10.1 = 052a1b5474b3681bc5f3167d2b3711a8
MD5_SUM_1.11   = b95de26a01338eec7a9b372d0fb24507


config: 
	cd $(O)  &&  $(srcdir)/configure --prefix=$(TOOLKIT_ROOT)

build:
	make -C $(O)

install: config build
        # Actually we probably only want fakeroot libfakeroot-0.so.
	make -C $(O) install
	cp $(srcdir)/config.guess $(TOOLKIT_ROOT)/bin


include ../RULES
