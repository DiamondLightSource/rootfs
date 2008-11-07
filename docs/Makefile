PATH := $(PATH):/dls_sw/tools/local/bin

ASCIIDOC_FILES = $(wildcard *.txt)

HTML_FILES = $(patsubst %.txt, %.html, $(ASCIIDOC_FILES))

default: $(HTML_FILES) 

clean:
	rm -f *.html *.xml

# Note that  --attribute=asciimath  doesn't work properly, as it interferes
# with listing and other passthrough text.
%.html: %.txt
	asciidoc --attribute=quirks! --section-numbers \
            --conf-file=macros.conf -o $@ $<
