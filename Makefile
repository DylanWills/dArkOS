SHELL := /bin/bash

all:
	@echo "Please specify a valid build target: make rgb10 or make rg353m"

rgb10:
	./build_rgb10.sh

rg353m:
	./build_rg353m.sh

clean:
	[ -d "mnt/boot" ] && sudo umount mnt/boot && sudo rm -rf mnt/boot || true
	[ -d "mnt/roms" ] && sudo umount mnt/roms && sudo rm -rf mnt/roms || true
	[ -d "main" ] && sudo rm -rf main || true
	[ -d "initrd" ] && sudo rm -rf initrd || true
	[ -f "wget-log" ] && sudo rm -f wget-log* || true
	source utils.sh && remove_arkbuild && remove_arkbuild32
	sudo rm -rf Arkbuild Arkbuild32 arkos_* mnt odroidgoA-4.4.y ArkOS_* wget-*
	@echo "Done!"

clean_complete: clean
	[ -d "${PWD}/Arkbuild_ccache" ] && sudo umount ${PWD}/Arkbuild_ccache || true
	[ -d "${PWD}/Arkbuild_ccache" ] && sudo rm -rf Arkbuild_ccache || true
	sudo rm -f build.log*
