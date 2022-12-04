#!/usr/bin/env bash

function setup() {
	shopt -s extglob
	_DESTINATION=${CLONEALL_DESTINATION:-"$HOME/Workshop"}
	_DESTINATION="${_DESTINATION%%+(/)}"
	_SSH=${CLONEALL_SSH:-false}

	if [ "$_DESTINATION" == "." ]; then
		_DESTINATION=$(pwd)
	fi

	if [ "$1" == "--ssh" ]; then
		_SSH=true
		shift 1
	fi

	_CONTEXT="users"
	_USERNAME="$1"
	shift 1
	debug "$(mkdir -vp "${_DESTINATION}/${_USERNAME}")" || return 1
}
