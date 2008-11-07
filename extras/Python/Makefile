TOP = $(CURDIR)/../..
include ../COMMON

Python_VERSION ?= 2.5.2

MD5_SUM_2.5.2 = afb5451049eda91fbde10bd5a4b7fadc

config: 
# 	cd $(O)  &&  \
#         $(srcdir)/configure --host=$(COMPILER_PREFIX) CFLAGS='$(CFLAGS)'

build:
# 	make -C $(O)

install:



include ../RULES

# See here for notes on cross-compiling Python (all gleaned from google: 
#   cross compiling python)
# http://whatschrisdoing.com/blog/2006/10/06/howto-cross-compile-python-25
# http://www.ailis.de/~k/archives/19-ARM-cross-compiling-howto.html
# http://kegel.com/crosstool/python.html

# Will need to fix up quite a few things which are tested on the local
# machine, for example have
#   AC_CHECK_FILE(/dev/ptmx, AC_DEFINE(HAVE_DEV_PTMX, 1))
# in 2.5 which seems to have mutated into an explicit 
#   if test -r /dev/ptmx; then AC_DEFINE(HAVE_DEV_PTMX, 1)
#
# Need to define HAVE_DEV_PTMX and try and catch any others like this.  Maybe
# the simplest thing will be to fudge this test, but properly it should be
# overridden from outside.
