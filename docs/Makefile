PATH := $(PATH):/dls_sw/tools/local/bin

ASCIIDOC_FILES = $(wildcard *.txt)
ASCIIDOC_ARGS = \
    --attribute=quirks! --section-numbers --conf-file=macros.conf

HTML_FILES = $(patsubst %.txt, %.html, $(ASCIIDOC_FILES))

default: $(HTML_FILES) 

clean:
	rm -f *.html *.xml *.pdf

# Note that  --attribute=asciimath  doesn't work properly, as it interferes
# with listing and other passthrough text.
%.html: %.txt
	asciidoc $(ASCIIDOC_ARGS) -o $@ $<

%.xml: %.txt
	asciidoc $(ASCIIDOC_ARGS) -b docbook -o $@ $<

# docbook2pdf needs docbook/xml/4.2/docbookx.dtd to be installed.
%.pdf: %.xml
	docbook2pdf $<
