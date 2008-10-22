include CONFIG

MKIMAGE = $(UBOOT_DIR)/mkimage

KERNEL_NAME = uImage-bare



# Note that this needs to be an absolute path!
O = $(CURDIR)/built/

default: deploy-boot-script


# ----------------------------------------------------------------------------

ifeq ($(shell id -u), 0)

$(O)rootfs:
	rm -rf $@
	mkdir -p $@
	scripts/skeleton $@
	scripts/populate $@ "$(BINUTILS_DIR)" "$(COMPILER_PREFIX)" 
	scripts/install-busybox $@ "$(BUSYBOX_DIR)"

$(O)imagefile.cpio: $(O)rootfs
	cd $< && find . | cpio --quiet -H newc -o >$@

.PHONY: $(O)rootfs

else

$(O)imagefile.cpio: $(O)
	umask 2  &&  $(FAKEROOT) make $(O)imagefile.cpio

.PHONY: $(O)imagefile.cpio

endif

imagefile: $(O)imagefile.cpio



# ----------------------------------------------------------------------------
# Assembles the final images and uploads them into the boot directory.

$(O): 
	mkdir $(O)

$(O)imagefile.cpio.gz: $(O)imagefile.cpio
	gzip -c -1 $< >$@

$(O)boot-script: $(O)imagefile.cpio.gz
	scripts/make-boot-script $< $(KERNEL_NAME) $@

$(O)boot-script.image: $(O)boot-script
	$(MKIMAGE) -T script -d $< $@

$(O)deploy-boot-script: $(O)boot-script.image $(O)imagefile.cpio.gz
	for f in $^; do \
            scp $$f serv3:/tftpboot; \
        done
	touch $@

deploy-boot-script: $(O)deploy-boot-script

.PHONY: deploy-boot-script

# ----------------------------------------------------------------------------

clean:
	rm -rf built

extras:
	make -C extras
