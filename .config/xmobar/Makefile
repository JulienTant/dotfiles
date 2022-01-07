INSTALL_DIR ?= ${HOME}/.local/bin

default: all

makeBuildDir:
	mkdir -p build/

left: makeBuildDir
	$(eval TEMP_DIR := $(shell mktemp -d))
	stack ghc -- --make xmobarLeft.hs -i -ilib -fforce-recomp -main-is main -v0 -o build/xmobarLeft -threaded -rtsopts -with-rtsopts -V0 -odir "$(TEMP_DIR)" -hidir "$(TEMP_DIR)"
	rm -r "$(TEMP_DIR)"

right: makeBuildDir
	$(eval TEMP_DIR := $(shell mktemp -d))
	stack ghc -- --make xmobarRight.hs -i -ilib -fforce-recomp -main-is main -v0 -o build/xmobarRight -threaded -rtsopts -with-rtsopts -V0 -odir "$(TEMP_DIR)" -hidir "$(TEMP_DIR)"
	rm -r "$(TEMP_DIR)"

clean:
	rm -rf build/

install:
	install build/xmobarLeft build/xmobarRight $(INSTALL_DIR)

all: left right
