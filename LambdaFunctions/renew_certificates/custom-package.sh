#!/bin/bash

# Preliminaries

set -eu -o pipefail

lambda="renew_certificates"

tmp=$(realpath "$0")
dir=$(dirname "$tmp")
cd "$dir"

if [ -e /etc/debian_version ]; then
    extra_pip_args=--system
else
    extra_pip_args=
fi
tmpdir=$(mktemp -d ./pkg-XXXXXXXX)
pip3 install $extra_pip_args --target "$tmpdir" -r requirements.txt
cd "$tmpdir"
zip -r9 "../${lambda}.zip" .
cd ..
rm -rf "$tmpdir"
zip -g "${lambda}.zip" *.py
zip -gj "${lambda}.zip" ../create_certificate/libarkcert.py
