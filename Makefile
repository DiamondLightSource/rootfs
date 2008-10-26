default: deploy-boot-script

TOP = $(CURDIR)
include COMMON

O = $(BUILD_ROOT)/


# ----------------------------------------------------------------------------

ifeq ($(shell id -u), 0)

$(sysroot):
	rm -rf $@
	mkdir -p $@
	$(scripts)skeleton $@
	$(scripts)populate $@ '$(BINUTILS_DIR)' '$(COMPILER_PREFIX)' 

$(EXTRAS): $(sysroot)
	make -C extras/$@ install

final-install: $(sysroot) $(EXTRAS) 

$(O)imagefile.cpio: final-install
	cd $(sysroot) && find . | cpio --quiet -H newc -o >$@

.PHONY: $(sysroot) final-install

else

$(O)imagefile.cpio: $(O)
	umask 22  &&  $(FAKEROOT) make $(O)imagefile.cpio

.PHONY: $(O)imagefile.cpio

endif

imagefile: $(O)imagefile.cpio



# ----------------------------------------------------------------------------
# Assembles the final images and uploads them into the boot directory.

$(O): 
	mkdir -p $(O)

$(O)imagefile.cpio.gz: $(O)imagefile.cpio
	gzip -c -1 $< >$@

$(O)boot-script: $(O)imagefile.cpio.gz
	$(scripts)make-boot-script $< $(KERNEL_NAME) '$(BOOTARGS)' $@

$(O)boot-script.image: $(O)boot-script
	$(MKIMAGE) -T script -d $< $@

deploy-boot-script: $(O)boot-script.image $(O)imagefile.cpio.gz
	for f in $^; do \
            scp $$f serv3:/tftpboot; \
        done

.PHONY: deploy-boot-script

# ----------------------------------------------------------------------------

$(EXTRAS:%=build_%):
	make -C $(@:build_%=extras/%)

build_extras: $(EXTRAS:%=build_%)


clean-all:
	rm -rf build

lssys:
	cpio -t -v --quiet <$(O)imagefile.cpio


.PHONY: build_extras clean-all lssys $(EXTRAS:%=build_%)
