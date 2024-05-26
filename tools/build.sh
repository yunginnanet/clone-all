#!/usr/bin/env bash
_TARGET=${CLONEALL_BUILD_TARGET:-"./"}
mkdir -vp "$_TARGET" || exit 1
rm "$_TARGET/clone-all" >/dev/null 2>&1 || true
set -e
echo '#!/usr/bin/env bash' >>"$_TARGET/clone-all"
cd src
cat ./*.sh | grep -v 'bin/bash' >>"$_TARGET/clone-all"
chmod +x "$_TARGET/clone-all"
echo -e "\e[0;33m[\e[0;32m+\e[0;33m]\e[0m built $_TARGET/clone-all"
