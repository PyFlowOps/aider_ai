#!/usr/bin/env bash

# This script will check if Homebrew is installed, and install it if it is not.
if test ! "$(command -v brew || true)"; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh || true)"
  echo "Homebrew installed."
else
  echo "Homebrew is already installed."
fi
