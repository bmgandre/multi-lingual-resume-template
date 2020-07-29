MAKE?=make

ifneq ($(DESTDIR),)
	export OUTPUT_PATH=$(realpath $(DESTDIR))
endif

all:
	$(MAKE) -C src all

.PHONY: pofile
pofile:
	$(MAKE) -C src pofile

.PHONY: translate
translate:
	$(MAKE) -C src translate

.PHONY: compile
compile:
	$(MAKE) -C src compile

.PHONY: unite
unite:
	$(MAKE) -C src unite

.PHONY: distclean
distclean:
	$(MAKE) -C src distclean

.PHONY: clean
clean:
	$(MAKE) -C src clean