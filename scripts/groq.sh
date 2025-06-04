#!/usr/bin/env bash

set -eo pipefail

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASEDIR="${BASE}/.."

[[ -z "${GROQ_API_KEY}" ]] && { echo "GROQ_API_KEY is not set"; exit 1; } # Assert the API is setup for GROQ
echo "Please see --> https://console.groq.com/keys"

"${BASEDIR}/dev/.python/bin/python" -m pip install --upgrade pip
"${BASEDIR}/dev/.python/bin/python" -m pip install -r "${BASEDIR}/requirements.txt"

export PATH="${HOME}/.local/bin:$PATH"

# Run the Aider install
"${BASEDIR}/dev/.python/bin/aider" --model groq/llama3-70b-8192
