TOP = $(CURDIR)
include COMMON

O = $(BUILD_ROOT)/$(TARGET)/


$(O): 
	mkdir -p $(O)


# ----------------------------------------------------------------------------

ifeq ($(shell id -u), 0)

$(sysroot):
	rm -rf $@
	mkdir -p $@
	make -C skeleton install
#	$(scripts)populate $@ '$(BINUTILS_DIR)' '$(COMPILER_PREFIX)' '$(TERMS)'
	$(call EXPORT,sysroot BINUTILS_DIR COMPILER_PREFIX TERMS) \
            $(scripts)populate
	$(first-time) 'rm /etc/first-time.sh'

$(EXTRAS): $(sysroot)
	make -C extras/$@ install

final-install: $(sysroot) $(EXTRAS) 

$(O)imagefile.cpio: final-install
	cd $(sysroot) && \
        find -name . -o -print | cpio --quiet -H newc -o >$@

.PHONY: $(sysroot) final-install

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


deploy-rootfs: $(BOOT_DEPENDS)
	make -C boot -f BOOT_$(BOOT) 

.PHONY: deploy-rootfs

# include boot/COMMON
# include boot/BOOT_$(BOOT)
# -include $(configdir)/BOOT_$(BOOT)




# ----------------------------------------------------------------------------

$(EXTRAS:%=build-%):
	make -C $(@:build-%=extras/%)

build-extras: $(EXTRAS:%=build-%)


clean-all:
	rm -rf build

lssys:
	cpio -t -v --quiet <$(O)imagefile.cpio


.PHONY: build_extras clean-all lssys $(EXTRAS:%=build_%)

default: deploy-rootfs
