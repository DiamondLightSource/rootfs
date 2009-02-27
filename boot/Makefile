BOOT_TARGETS = $(wildcard BOOT_*)

default:
	$(error Specify a boot target)

$(BOOT_TARGETS:BOOT_%=%): %: BOOT_%

$(BOOT_TARGETS):
	make -f $@ BOOT=$(@:BOOT_%=%) default

.PHONY: $(BOOT_TARGETS)
