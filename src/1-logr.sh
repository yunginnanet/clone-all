#!/usr/bin/env bash

LPLUS="\e[0;33m[\e[0;32m+\e[0;33m]\e[0m"
LFAIL="\e[0;33m[\e[1;31mx\e[0;33m]\e[0m"
LFOOB="\e[0;33m[\e[90m-\e[0;33m]\e[0m"
REDIR="\e[0;90m"
LWOOT="\e[0;32mSuccess\e[0m"
LNOPE="\e[31mError\e[0m"
FATAL="\e[1;31m"
RESET="\e[0m"
LAST=""
function _t() {
	echo -e "\e[90m[$(date -u +'%H:%M:%S')]${RESET}"
}
function cln() {
	# shellcheck disable=SC2001
	echo "$*" | sed -z 's|\n| |g'
}
function log() {
	LAST="${*}..."
	echo -ne "$(cln "$(_t) ${LFOOB} ${LAST}")"
}
function log0() {
	echo -ne "\r$(cln "$(_t) ${LPLUS} ${LAST}${LWOOT}${RESET}")\n"
	LAST=""
}
function log1() {
	echo -ne "\r$(cln "$(_t) ${LFAIL} ${LAST}${LNOPE}${RESET}")\n"
	LAST=""
}
function log2() {
	NEW="${LAST//Cloning/Updating}${REDIR}${*}... ${RESET}"
	echo -ne "\r$(cln "$(_t) ${LFOOB} ${NEW}")"
	LAST=$NEW
}
function logln() {
	echo -e "$(_t) ${LFOOB} ${*}"
}
function debug() {
	if [ -z "$*" ]; then return 0; fi
	echo -e "$(cln "$(_t) ${LFOOB} \e[90m$*${RESET}")"
}
function err() {
	echo -e "$(cln "$(_t) ${LFAIL} ${LERRD}${*//fatal: /} ${RESET}")"
}
function fatal() {
	err "${FATAL}[FATAL]${RESET}: $*"
	exit 1
}
function testLogger() {
	log "trying to yeet"
	sleep 1
	log0
	log "trying to yort"
	sleep 1
	log1
	log "trying to yeeeeeeeeeeet"
	sleep 1
	log2 "Slowing it down"
	sleep 1
	log0
}
