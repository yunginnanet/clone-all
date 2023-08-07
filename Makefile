CLONEALL_BUILD_TARGET := $(shell pwd -P)
CLONEALL_INSTALL_TARGET := ${HOME}/.local/bin

.EXPORT_ALL_VARIABLES:
	export CLONEALL_BUILD_TARGET
	export CLONEALL_INSTALL_TARGET

all: .EXPORT_ALL_VARIABLES build install

build: .EXPORT_ALL_VARIABLES
	./tools/build.sh

clean:
	rm -v clone-all

install: .EXPORT_ALL_VARIABLES build
	./tools/install.sh

uninstall: .EXPORT_ALL_VARIABLES
	rm -v "${CLONEALL_INSTALL_TARGET}"
