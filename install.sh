#!/usr/bin/env bash
set -e
_target="$HOME/.local/bin"
mkdir -vp "$_target"
set +e
rm "${_target}/clone-all" 2 &>/dev/null
set -e
echo '#!/usr/bin/env bash' >>"${_target}/clone-all"
cd src
cat ./*.sh | grep -v 'usr/bin/env' >>"${_target}/clone-all"
chmod +x "${_target}/clone-all"
if ! [[ ":$PATH:" == *":$_target:"* ]]; then
	echo "Your PATH is missing '$_target', consider adding it."
fi
cd ..
if ! ls -lah "${_target}/clone-all" >/dev/null; then
	echo "installation failed somehow"
fi
echo "clone-all installed to: ${_target}/clone-all"
