#!/usr/bin/env bash

function update() {
	#debug "Update input: $1"
	_TARGET="${_DESTINATION}/${_USERNAME}/$1"
	#debug "$(mkdir -vp "$_TARGET")"
	if ! cd "$_TARGET"; then
		log1
		err "failed to change directory to update $1"
		return 1
	fi
	if ! _F=$( (git fetch >&1) 2>&1); then
		log1
		err "$_F"
		return 1
	fi
	if ! _P=$( (git pull >&1) 2>&1); then
		log1
		err "$_P"
		return 1
	fi
	# shellcheck disable=SC2076
	if [[ "$_P" =~ "Already up to date." ]]; then
		echo -e "Current"
		return 0
	fi
	log0
	return 0
}
