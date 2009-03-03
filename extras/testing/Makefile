TOP = $(CURDIR)/../..
include $(CURDIR)/../COMMON
include $(CURDIR)/../EXTRAS

testing_VERSION = local

LDLIBS += -lrt

TEST_FILES = testing timestamps

build-local: $(TEST_FILES)

install:
	$(install) -s -m-w $(TEST_FILES:%=$(O)/%) /usr/bin


include $(CURDIR)/../RULES
