NAME=$(shell basename $$PWD)

.PHONY: html
html:
	asciidoctor -D build/html book.adoc

pdf: clean-pdf build/pdf/$(NAME).pdf

build/pdf/book.pdf: book.adoc
	asciidoctor-pdf -D build/pdf -r asciidoctor-pdf-cjk -a pdf-stylesdir=resources/themes -a pdf-style=basic book.adoc

build/pdf/$(NAME).pdf: build/pdf/book.pdf
	perl bin/finish.pl $< $@

.PHONY: all
all: html pdf

.PHONY: clean
clean:
	rm -rf build

.PHONY: clean-pdf
clean-pdf:
	rm -rf build/pdf
