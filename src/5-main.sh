#!/usr/bin/env bash

if ! setup "$@"; then
	fatal "Failed to setup directory structure!"
fi
logln "Cloning all repos owned by $_USERNAME into ${_DESTINATION}/${_USERNAME}/"
get
echo -e "\e[1;32mfin.\e[0m"
