# Simple wrapper for dir: delegates any -all target to each subdirectory.

ALL_EXTRAS = $(shell find -maxdepth 1 -mindepth 1 -type d ! -name .svn | sort)

%-all:
	for dir in $(ALL_EXTRAS); do \
            make -C $$dir $(@:-all=)  ||  exit 1; \
        done
