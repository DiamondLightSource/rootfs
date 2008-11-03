TOP = $(CURDIR)/../..
include $(CURDIR)/../COMMON
include $(CURDIR)/../EXTRAS

testing_VERSION = local

TEST_FILES = testing

build-local: $(TEST_FILES)

install:
	for f in $(TEST_FILES); do \
            $(install) $(O)/$$f /usr/bin; \
        done


include $(CURDIR)/../RULES
