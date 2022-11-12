#!/usr/bin/env bash

export _DESTINATION="$HOME/Workshop/"

# ----------------------------------
LPLUS="\e[0;33m[\e[0;32m+\e[0;33m]\e[0m"
LFAIL="\e[0;33m[\e[1;31mx\e[0;33m]\e[0m"
LFOOB="\e[0;33m[\e[90m-\e[0;33m]\e[0m"
LWOOT="\e[0;32mSuccess\e[0m!"
FATAL="\e[1;31m"
RESET="\e[0m"
function _t() {
	echo -e "\e[90m[$(date -u +'%H:%M:%S')]${RESET}"
}
function log() {
	echo -e "$(_t) ${LPLUS} $* ${RESET}"
}
function debug() {
	echo -e "$(_t) ${LFOOB} \e[90m$*${RESET}"
}
function err() {
	echo -e "$(_t) ${LFAIL} \e[31mError: \e[0m${*//fatal: /} ${RESET}"
}
function fatal() {
	err "${FATAL}FATAL${RESET}: $*"
	exit 1
}
#-----------------------------------

function get() {
	_PAGE=1
	while :; do
		_APIRES=$(curl -s "https://api.github.com/$_CONTEXT/$_USERNAME/repos?page=$_PAGE&per_page=100")
		if [[ "$_APIRES" =~ "clone_url" ]]; then
			_URLS=$(echo "$_APIRES" | grep "clone_url" | awk -F '"' '{print $4}')
			if $_SSH; then _URLS=${_URLS//https:\/\//ssh:\/\/git@}; fi
			while read -r line; do
				if ! cd "${_DESTINATION}/${_USERNAME}"; then
					fatal "failed to change directory to ${_DESTINATION}/${_USERNAME}"
				fi
				if _RES=$( (git clone "$line" >&1) 2>&1); then
					log "${_RES}${LWOOT}"
				elif [[ "$_RES" =~ "already exists" ]]; then
					update "$(echo "$_RES" | awk -F "'" '{print $2}')"
					continue
				else
					_REPO="$(echo "$line" | awk -F '/' '{print $NF}' | awk -F '.' '{print $0}')"
					err "${_DESTINATION}/${_USERNAME}/ $_RES"
					continue
				fi
			done < <(echo "$_URLS")
			(("_PAGE = $_PAGE + 1"))
		elif [[ "$_APIRES" =~ [a-zA-Z] ]]; then
			echo -e "\e[1;31mbad response from API:\e[0m"
			echo "$_APIRES"
			exit 1
		elif ! [[ "$_APIRES" =~ [a-zA-Z] ]]; then
			echo "$_APIRES"
			break
		fi
	done
}

function update() {
	if ! cd "$1"; then
		err "failed to change directory to update $1"
		return 1
	fi
	if ! _F=$( (git fetch >&1) 2>&1); then
		# shellcheck disable=SC2001,SC2086
		err "$(echo ${_F} | sed 's|\n| |g')"
		return 1
	fi
	if ! _P=$( (git pull >&1) 2>&1); then
		# shellcheck disable=SC2001,SC2086
		err "$(echo ${_P} | sed 's|\n| |g')"
		return 1
	fi
	# shellcheck disable=SC2076
	if ! [[ "$_P" =~ "Already up to date." ]]; then
		log "Updating '$1'...${LWOOT}"
		return 0
	else
		debug "$1 already up to date"
		return 0
	fi
}

function setup() {
	if [ "$1" == "--ssh" ]; then
		export _SSH=true
		shift 1
	fi
	export _CONTEXT="users"
	export _USERNAME="$1"
	shift 1
	if ! mkdir -p "$_DESTINATION/$_USERNAME"; then return 1; fi
	if ! cd "$_DESTINATION/$_USERNAME"; then return 1; fi
}

export _SSH=false
if ! setup "$@"; then
	fatal "Failed to setup directory structure!"
fi
targ="$1"
if $_SSH; then targ="$2"; fi
log "cloning all repos owned by $targ into $(pwd)/"
get
echo -e "\e[1;32mfin.\e[0m"
