#PATH := $(PATH):/dls_sw/tools/local/bin
# PATH := $(PATH):

ASCIIDOC = /home/share/embedded/local/bin/asciidoc

ASCIIDOC_FILES = $(wildcard *.txt)

HTML_FILES = $(patsubst %.txt, %.html, $(ASCIIDOC_FILES))

default: $(HTML_FILES) 

clean:
	rm -f *.html *.xml

# Note that  --attribute=asciimath  doesn't work properly, as it interferes
# with listing and other passthrough text.
%.html: %.txt
	asciidoc --attribute=quirks! --section-numbers  -o $@ $<
