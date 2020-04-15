# This makefile was automatically written by inweb -makefile
# and is not intended for human editing

ME = inweb
SAFETYCOPY = $(ME)/Tangled/inweb_dev

COLONY = $(ME)/colony.txt

-include $(ME)/platform-settings.mk

.PHONY: all

all: $(ME)/platform-settings.mk $(ME)/Tangled/$(ME)

$(ME)/Tangled/$(ME): $(ME)/Contents.w $(ME)/Chapter*/*.w $(ME)/foundation-module/Contents.w $(ME)/foundation-module/Chapter*/*.w
	$(call make-me)

.PHONY: force
force: $(ME)/platform-settings.mk
	$(call make-me)

.PHONY: macos
macos: 
	cp -f $(ME)/Materials/macos-make-settings.mk $(ME)/platform-settings.mk
	echo "=== Platform set to 64-bit MacOS. Now: make -f inweb/inweb.mk initial ==="

.PHONY: macos32
macos32:
	cp -f $(ME)/Materials/macos32-make-settings.mk $(ME)/platform-settings.mk
	echo "=== Platform set to 32-bit MacOS. Now: make -f inweb/inweb.mk initial ==="

.PHONY: windows
windows: 
	cp -f $(ME)/Materials/windows-make-settings.mk $(ME)/platform-settings.mk
	echo "=== Platform set to Windows. Now: make -f inweb/inweb.mk initial ==="

.PHONY: linux
linux: 
	cp -f $(ME)/Materials/linux-make-settings.mk $(ME)/platform-settings.mk
	echo "=== Platform set to Linux. Now: make -f inweb/inweb.mk initial ==="

.PHONY: unix
unix: 
	cp -f $(ME)/Materials/unix-make-settings.mk $(ME)/platform-settings.mk
	echo "=== Platform set to generic Unix (non-Linux, non-MacOS, non-Android). Now: make -f inweb/inweb.mk initial ==="

.PHONY: android
android: 
	cp -f $(ME)/Materials/android-make-settings.mk $(ME)/platform-settings.mk
	echo "=== Platform set to Android. Now: make -f inweb/inweb.mk initial ==="

.PHONY: initial
initial: $(ME)/platform-settings.mk
	$(call make-me-once-tangled)

.PHONY: safe
safe:
	$(call make-me-using-safety-copy)

define make-me-once-tangled
	$(CC) -o $(ME)/Tangled/$(ME).o $(ME)/Tangled/$(ME).c
	$(LINK) -o $(ME)/Tangled/$(ME) $(ME)/Tangled/$(ME).o $(LINKEROPTS)
endef

define make-me
	$(ME)/Tangled/$(ME) $(ME) -tangle
	$(call make-me-once-tangled)
endef

define make-me-using-safety-copy
	$(SAFETYCOPY) $(ME) -tangle
	$(call make-me-once-tangled)
endef

.PHONY: test
test:
	$(INTEST) -from $(ME) all

.PHONY: commit
commit:
	$(INWEB) -advance-build-file $(ME)/build.txt
	$(INWEB) -prototype inweb/scripts/READMEscript.txt -write-me inweb/README.md
	cd $(ME); git commit -a

.PHONY: pages
pages:
	$(INWEB) -help > $(ME)/Figures/help.txt
	$(INWEB) -show-languages > $(ME)/Figures/languages.txt
	cp -f $(COLONY) $(ME)/Figures/colony.txt
	cp -f $(ME)/docs/docs-src/nav.html $(ME)/Figures/nav.txt
	$(INWEB) -advance-build-file $(ME)/build.txt
	mkdir -p $(ME)/docs
	rm -f $(ME)/docs/*.html
	$(INWEB) -prototype inweb/scripts/READMEscript.txt -write-me inweb/README.md
	mkdir -p $(ME)/docs/inweb
	rm -f $(ME)/docs/inweb/*.html
	mkdir -p $(ME)/docs/goldbach
	rm -f $(ME)/docs/goldbach/*.html
	mkdir -p $(ME)/docs/twinprimes
	rm -f $(ME)/docs/twinprimes/*.html
	mkdir -p $(ME)/docs/eastertide
	rm -f $(ME)/docs/eastertide/*.html
	mkdir -p $(ME)/docs/foundation-module
	rm -f $(ME)/docs/foundation-module/*.html
	mkdir -p $(ME)/docs/foundation-test
	rm -f $(ME)/docs/foundation-test/*.html
	$(INWEB) -colony $(COLONY) -member overview -weave
	$(INWEB) -colony $(COLONY) -member goldbach -weave
	$(INWEB) -colony $(COLONY) -member twinprimes -weave
	$(INWEB) -colony $(COLONY) -member eastertide -weave
	$(INWEB) -colony $(COLONY) -member inweb -weave
	$(INWEB) -colony $(COLONY) -member foundation -weave
	$(INWEB) -colony $(COLONY) -member foundation-test -weave

.PHONY: clean
clean:
	$(call clean-up)

.PHONY: purge
purge:
	$(call clean-up)

define clean-up
	rm -f $(ME)/Tangled/*.o
	rm -f $(ME)/Tangled/*.h
endef

