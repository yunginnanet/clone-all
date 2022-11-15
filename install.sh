#!/usr/bin/env bash
set -e

_target="$HOME/.local/bin"
mkdir -vp "$_target"
rm -v "${_target}/clone-all"
echo '#!/usr/bin/env bash' >> "${_target}/clone-all"
cd src
cat ./*.sh | grep -v 'usr/bin/env' >>"${_target}/clone-all"
chmod +x "${_target}/clone-all"
if ! [[ ":$PATH:" == *":$_target:"* ]]; then
	echo "Your PATH is missing '$_target', consider adding it."
fi
echo "fin."
