#!/usr/bin/env bash
set -e

_target="$HOME/.local/bin"

mkdir -p "$_target"
rm -vrf "${_target}/clone-all"
cp -v clone-all.sh "${_target}/clone-all"
if ! [[ ":$PATH:" == *":$_target:"* ]]; then
  echo "Your PATH is missing '$_target', consider adding it."
fi
echo "fin."
