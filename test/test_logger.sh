#!/usr/bin/env bash
set -e

# shellcheck disable=SC1091
source ./src/1-logr.sh 2&>/dev/null|| source ../src/1-logr.sh

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

testLogger
