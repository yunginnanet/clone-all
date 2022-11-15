#!/usr/bin/env bash

function get() {
	_PAGE=1
	while :; do
		_APIRES=$(curl -s "https://api.github.com/$_CONTEXT/$_USERNAME/repos?page=$_PAGE&per_page=100")
		if ! [[ "$_APIRES" =~ "clone_url" ]]; then
			if [[ "$_APIRES" =~ [a-zA-Z] ]]; then
				echo "$_APIRES"
				fatal "\e[1;31mbad response from API\e[0m"
			fi
			break
		fi
		_URLS=$(echo "$_APIRES" | grep "clone_url" | awk -F '"' '{print $4}')
		if $_SSH; then _URLS=${_URLS//https:\/\//ssh:\/\/git@}; fi
		while read -r line; do
			_REPO="$(echo "$line" | awk -F '/' '{print $NF}' | awk -F '.' '{print $0}' | sed 's|.git||g')"
			_TARGET="${_DESTINATION}/${_USERNAME}/${_REPO}"
			log "Cloning '$_REPO'"
			if _RES=$( (git clone "$line" "$_TARGET" >&1) 2>&1); then
				log0
				continue
			fi

			if [[ "$_RES" =~ "already exists" ]]; then
				log2 "Updating"
				update "$_REPO"
				continue
			fi
			err "(${_REPO}) $_RES"
			continue
		done < <(echo "$_URLS")

		(("_PAGE = $_PAGE + 1"))
	done
}
