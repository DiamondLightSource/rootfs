TOP = $(CURDIR)
include COMMON

O = $(BUILD_ROOT)/$(TARGET)/


$(O):
	mkdir -p $(O)


# ----------------------------------------------------------------------------

ifeq ($(shell id -u), 0)

$(sysroot):
	rm -rf $@  &&  mkdir -p $@
	make -C skeleton pre-install
	for extra in $(EXTRAS); do \
            make -C extras/$$extra install; \
        done
	make -C skeleton post-install

final-install:: $(sysroot)

$(O)imagefile.cpio: $(sysroot) final-install
	cd $(sysroot) && \
        find -name . -o -print | cpio --quiet -H newc -o >$@

.PHONY: $(sysroot)

else

$(O)imagefile.cpio: $(O)
	umask 22  &&  fakeroot -s $(O)fakeroot.env make $(O)imagefile.cpio

.PHONY: $(O)imagefile.cpio

endif

imagefile: $(O)imagefile.cpio



# ----------------------------------------------------------------------------
# Assembles the final images and uploads them into the boot directory.
#
# These are all gathered into a single target, deploy-rootfs

BOOT_DEPENDS ?= $(BOOT_$(BOOT)_DEPENDS)

BOOT_nfs_DEPENDS = $(O)imagefile.cpio
BOOT_initramfs_DEPENDS = $(O)imagefile.cpio
BOOT_jffs2_DEPENDS = $(sysroot)

deploy-rootfs: $(BOOT_DEPENDS)
	make -C boot -f BOOT_$(BOOT)

.PHONY: deploy-rootfs



# ----------------------------------------------------------------------------

$(EXTRAS:%=build-%):
	make -C $(@:build-%=extras/%)

build-extras: $(EXTRAS:%=build-%)

.PHONY: build-extras  $(EXTRAS:%=build-%)


default: deploy-rootfs
