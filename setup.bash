#!/bin/bash

echo "Installing system dependencies for SUMO"

# Quick check that we actually have brew, if not, lets install it
command -v brew >/dev/null 2>&1 || 
  echo "Homebrew is missing. Let's install it." || 
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

# script dependencies
# brew install wget