#!/usr/bin/env bash

set -eo pipefail

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASEDIR="${BASE}/.."

"${BASEDIR}/dev/.python/bin/python" -m pip install --upgrade pip
"${BASEDIR}/dev/.python/bin/python" -m pip install -r "${BASEDIR}/requirements.txt"

export PATH="${HOME}/.local/bin:$PATH"

# Run the Aider install
"${BASEDIR}/dev/.python/bin/aider-install"
