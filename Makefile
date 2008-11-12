TOP = $(CURDIR)
include COMMON

O = $(BUILD_ROOT)/$(TARGET)/

FAKEROOT = $(TOOLKIT_BIN)/fakeroot

$(O): 
	mkdir -p $(O)


# ----------------------------------------------------------------------------

ifeq ($(shell id -u), 0)

$(sysroot):
	rm -rf $@
	mkdir -p $@
	make -C skeleton install
	$(scripts)populate $@ '$(BINUTILS_DIR)' '$(COMPILER_PREFIX)' '$(TERMS)'

$(EXTRAS): $(sysroot)
	make -C extras/$@ install

final-install: $(sysroot) $(EXTRAS) 

$(O)imagefile.cpio: final-install
	$(first-time) 'rm /etc/first-time.sh'
	cd $(sysroot) && \
        find -name . -o -print | cpio --quiet -H newc -o >$@

.PHONY: $(sysroot) final-install

else

$(O)imagefile.cpio: $(O)
	umask 22  &&  $(FAKEROOT) make $(O)imagefile.cpio

.PHONY: $(O)imagefile.cpio

endif

imagefile: $(O)imagefile.cpio



# ----------------------------------------------------------------------------
# Assembles the final images and uploads them into the boot directory.

deploy-rootfs: 
.PHONY: deploy-rootfs


$(O)boot-script.image: $(O)boot-script
	$(MKIMAGE) -T script -d $< $@

ifeq ($(BOOT),initramfs)
$(O)imagefile.cpio.gz: $(O)imagefile.cpio
	gzip -c -1 $< >$@

$(O)boot-script: $(O)imagefile.cpio.gz
	$(scripts)make-boot-script $@ $(KERNEL_NAME) '$(BOOTARGS)' $<

deploy-rootfs: $(O)boot-script.image $(O)imagefile.cpio.gz
	for f in $^; do \
            scp $$f serv3:/tftpboot; \
        done
else

ifeq ($(BOOT),nfs)
$(O)boot-script: $(O)imagefile.cpio
	$(scripts)make-nfsboot-script $@ '$(KERNEL_NAME)' '$(BOOTARGS)' \
            '$(NFS_NFSROOT)' '$(NFS_IP_STRING)'

deploy-rootfs: $(O)imagefile.cpio $(O)boot-script.image
	ssh -t $(NFS_SERVER) \
            'sudo rm -rf $(NFS_ROOTFS); mkdir -p $(NFS_ROOTFS)'
	scp $(O)imagefile.cpio $(NFS_SERVER):/tmp
	ssh -t $(NFS_SERVER) \
            'cd $(NFS_ROOTFS) && \
             sudo cpio -i </tmp/imagefile.cpio'
	ssh $(NFS_SERVER) rm /tmp/imagefile.cpio
	scp $(O)boot-script.image serv3:/tftpboot

else

ifeq ($(BOOT),jffs2)
$(error Don't know how to do jffs2 yet)
else

ifeq ($(BOOT),)
deploy-rootfs: $(O)imagefile.cpio
else
$(error Boot option BOOT=$(BOOT) not recognised)
endif
endif
endif
endif




# ----------------------------------------------------------------------------

$(EXTRAS:%=build_%):
	make -C $(@:build_%=extras/%)

build_extras: $(EXTRAS:%=build_%)


clean-all:
	rm -rf build

lssys:
	cpio -t -v --quiet <$(O)imagefile.cpio


.PHONY: build_extras clean-all lssys $(EXTRAS:%=build_%)

default: deploy-rootfs
