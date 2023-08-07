#!/usr/bin/env bash
set -e
_TARGET=${CLONEALL_INSTALL_TARGET:-"$HOME/.local/bin"}
install -v -b -C -D "$(pwd)/clone-all" "$_TARGET"
if ! [[ ":$PATH:" == *":$_TARGET:"* ]]; then
	echo "Your PATH is missing '$_TARGET', consider adding it."
fi
cd ..
if ! ls -lah "${_TARGET}/clone-all" >/dev/null; then
	echo "installation failed somehow, clone-all should have existed at ${_TARGET}/clone-all"
	mv -vf "$_TARGET/clone-all~" "$_TARGET/clone-all"
	exit 1
fi
echo -e "\e[0;33m[\e[0;32m+\e[0;33m]\e[0m installed ${_TARGET}/clone-all"
