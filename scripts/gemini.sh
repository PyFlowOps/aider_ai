#!/usr/bin/env bash

set -eo pipefail

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASEDIR="${BASE}/.."

[[ -z "${GEMINI_API_KEY}" ]] && { echo "GEMINI_API_KEY is not set"; exit 0; } # Assert the API is setup for GROQ
echo "Please see --> https://aistudio.google.com/apikey"

"${BASEDIR}/dev/.python/bin/python" -m pip install --upgrade pip
"${BASEDIR}/dev/.python/bin/python" -m pip install -r "${BASEDIR}/requirements.txt"

export PATH="${HOME}/.local/bin:$PATH"

# Run the Aider install
"${BASEDIR}/dev/.python/bin/python" -m uv run aider --model gemini/gemini-2.5-pro-exp-03-25
