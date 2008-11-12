TOP = ..
include COMMON

$(TOOLKIT_BIN)/%: %
	make -C $< install

$(TOOLKIT_BIN)/autoconf: $(TOOLKIT_BIN)/m4

all: $(TOOLKIT_BIN)/fakeroot $(TOOLKIT_BIN)/autoconf

clean:
	rm -rf $(TOOLKIT_ROOT)
