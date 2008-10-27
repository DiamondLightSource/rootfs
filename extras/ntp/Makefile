TOP = $(CURDIR)/../..
include ../COMMON

TAR_EXTENSION = .tar.gz
MD5_SUM_4.2.2p3 = 45cee6d1ebf8fe46e412fd818b8e7b74
MD5_SUM_4.2.4p5 = eb647e07ecbd6e9e07bf8d3dc555490e
ntp_VERSION ?= 4.2.4p5

NTP_CONF ?= $(CURDIR)/ntp.conf


config: 
	cd $(srcdir)  &&  ./configure --host=$(COMPILER_PREFIX) \
            --disable-all-clocks --disable-parse-clocks 

build:
	make -C $(srcdir)

install:
	$(install) -m 555 $(srcdir)/ntpd/ntpd /usr/sbin 
	$(install) $(NTP_CONF) /etc
	$(startup) $(CURDIR)/ntpd S20


include ../RULES
