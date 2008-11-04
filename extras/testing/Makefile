TOP = $(CURDIR)/../..
include $(CURDIR)/../COMMON
include $(CURDIR)/../EXTRAS

testing_VERSION = local

TEST_FILES = testing

build-local: $(TEST_FILES)

install:
	$(install) $(TEST_FILES:%=$(O)/%) /usr/bin


include $(CURDIR)/../RULES
