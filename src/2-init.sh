#!/bin/bash

function reqs() {
	if ! command -v git &>/dev/null; then
		fatal "please install git to use this tool"
	fi
}

function usage() {
	echo -e "\n\t\tclone-all\neasily clone/update a target's github repos\n"
	# shellcheck disable=SC2086
	echo -e "usage: $(echo $0 | awk -F '/' '{print $NF}') [OPTION...] TARGET\n"
	echo -e "OPTION\n"
	echo -e "  -v \e[90m--verbose\e[0m\n\tenable debug output"
	echo -e "  -d \e[90m--destination\e[0m\n\tset clone output folder"
	echo -e "  -s \e[90m--ssh\e[0m\n\tuse ssh instead of https"
	echo -e "  -h \e[90m--help\e[0m\n\tshow this help message"
	echo -e "  -t \e[90m--target\e[0m\n\talternative way to set TARGET explicitly"
}

function setup() {
	reqs
	shopt -s extglob
	_DESTINATION=${CLONEALL_DESTINATION:-"$HOME/Workshop"}
	_SSH=${CLONEALL_SSH:-false}
	_APIKEY=${GITHUB_TOKEN:-""}
	_CONTEXT="users"

	if [ "$_DESTINATION" == "." ]; then
		_DESTINATION=$(pwd)
	fi

	_HASTARG=false
	while [[ $# -gt 0 ]]; do
		case $1 in
		"-v" | "--verbose")
			_DEBUG=true
			debug "debug mode enabled"
			shift
			;;
		"-d" | "--destination")
			_DESTINATION="$1"
			debug "_DESTINATION set to: $_DESTINATION"
			shift
			;;
		"-s" | "--ssh")
			_SSH=true
			debug "using ssh instead of https"
			shift
			;;
		"-h" | "--help")
			usage
			exit 0
			;;
		"-t" | "--target")
			_USERNAME="$1"
			debug "target set to: $_USERNAME"
			shift
			;;
		*)
			if [[ "$1" == "-"* ]]; then
				err "unknown argument: $1"
				usage
				exit 1
			fi
			_USERNAME="$1"
			debug "target set to: $_USERNAME"
			shift
			;;
		esac
	done

	if [[ "$_USERNAME" == "" ]]; then
		fatal "need target github user"
		usage
		exit 1
	fi

	_DESTINATION="${_DESTINATION%%+(/)}"

	export _CONTEXT
	export _DESTINATION
	export _SSH
	export _USERNAME
	shift 1
	debug "$(mkdir -vp "${_DESTINATION}/${_USERNAME}")" || return 1
}
