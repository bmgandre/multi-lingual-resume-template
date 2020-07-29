OUTPUT_PATH?=.
LATEX?=pdflatex -output-directory=$(OUTPUT_PATH)

# Prefix for output file
OUTPUT_PREFIX=surname
# curriculum vitae prefix
CV_PREFIX=cv_surname
# cover letter prefix
LT_PREFIX=lt_surname

# original language (source)
LANG_ORIGINAL=en
# destination language (target)
LANG_TRANSLATED=ptbr

# curriculum vitae filename
CV_ORIGINAL_TEX=$(CV_PREFIX)-$(LANG_ORIGINAL).tex
# cover letter filename
LT_ORIGINAL_TEX=$(LT_PREFIX)-$(LANG_ORIGINAL).tex

# translated curriculum vitae filename
CV_TRANSLATED_TEX=$(CV_PREFIX)-$(LANG_TRANSLATED).tex
# translated cover letter filename
LT_TRANSLATED_TEX=$(LT_PREFIX)-$(LANG_TRANSLATED).tex

# curriculum vitae translation file (gettext)
CV_PO=$(CV_PREFIX).po
# cover letter translation file (gettext)
LT_PO=$(LT_PREFIX).po

# original pdf filename
RESUME_ORIGINAL_PDF=$(OUTPUT_PREFIX)-$(LANG_ORIGINAL).pdf
# translated pdf filename
RESUME_TRANSLATED_PDF=$(OUTPUT_PREFIX)-$(LANG_TRANSLATED).pdf

# all source files
SOURCE_LIST=$(CV_ORIGINAL_TEX) $(LT_ORIGINAL_TEX) $(CV_TRANSLATED_TEX) $(LT_TRANSLATED_TEX)
# original source files
SOURCE_ORIGINAL_LIST=$(CV_ORIGINAL_TEX) $(LT_ORIGINAL_TEX)
# translated source files
SOURCE_TRANSLATED_LIST=$(CV_TRANSLATED_TEX) $(LT_TRANSLATED_TEX)
# all PDFs
OUTPUT_PDF_LIST=$(RESUME_ORIGINAL_PDF) $(RESUME_TRANSLATED_PDF)

%.pdf:%.tex
ifeq ($(wildcard $@),)
	$(LATEX) $<
	$(LATEX) $<
endif

%.po:%.tex
	po4a-updatepo \
	-f latex \
	-m $< \
	-M UTF8 \
	-p $(@:-$(LANG_ORIGINAL).po=.po)

%ptbr.tex:%en.tex $(subst, $(LANG_TRANSLATED), $(LANG_ORIGINAL), %.po)
	po4a-translate \
	-f latex \
	-m $(word 1, $^) \
	-M UTF8 \
	-a addendum.txt \
	-p $(subst -$(LANG_ORIGINAL).tex,.po,$(word 1, $^)) \
	-l $(<:$(LANG_ORIGINAL).tex=$(LANG_TRANSLATED).tex)

$(OUTPUT_PREFIX)%.pdf:lt_$(OUTPUT_PREFIX)%.pdf cv_$(OUTPUT_PREFIX)%.pdf
	pdftk $(OUTPUT_PATH)/$(word 1, $^) dump_data_utf8 | grep Info > $(OUTPUT_PATH)/$@.metadata
	pdftk $(OUTPUT_PATH)/$(word 1, $^) $(OUTPUT_PATH)/$(word 2, $^) output - | \
	pdftk - update_info_utf8 $(OUTPUT_PATH)/$@.metadata output $(OUTPUT_PATH)/$@

all: pofile translate compile unite

.PHONY: pofile
pofile: $(SOURCE_ORIGINAL_LIST:.tex=.po)

.PHONY: translate
translate: $(SOURCE_TRANSLATED_LIST)

.PHONY: compile
compile: $(SOURCE_LIST:.tex=.pdf)

.PHONY: unite
unite: $(OUTPUT_PDF_LIST)

.PHONY: distclean
distclean: clean
	rm -f $(SOURCE_LIST:.tex=.pdf)
	rm -f $(OUTPUT_PDF_LIST)
	rm -f $(CV_TRANSLATED_TEX) $(LT_TRANSLATED_TEX)
	rm -f *.lokalize
	rm -rf lokalize-scripts

.PHONY: clean
clean:
	rm -f $(SOURCE_LIST:.tex=.aux)
	rm -f $(SOURCE_LIST:.tex=.log)
	rm -f $(SOURCE_LIST:.tex=.out)
	rm -f $(SOURCE_LIST:.tex=.synctex.gz)
	rm -f $(SOURCE_LIST:.tex=.fls)
	rm -f $(SOURCE_LIST:.tex=.fdb_latexmk)
	rm -f $(CV_PREFIX).mo
	rm -f $(LT_PREFIX).mo
	rm -f $(OUTPUT_PDF_LIST:.pdf=.pdf.metadata)
	rm -f *~
