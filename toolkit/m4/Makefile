TOP = $(CURDIR)/../..
include ../COMMON

m4_VERSION ?= 1.4.12

MD5_SUM_1.4.12 = b3587c993523dd320c318ec456876839


config: 
	cd $(O)  &&  $(srcdir)/configure --prefix=$(OBJECT_ROOT)

build:
	make -C $(O)

install: config build
	make -C $(O) install


include ../RULES
