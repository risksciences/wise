#!/bin/bash

ring_bell() {
  # Use the shell's audible bell.
  if [[ -t 1 ]]
  then
    printf "\a"
  fi
}

ohai "Installing system dependencies for SUMO"

# Quick check that we actually have brew
command -v brew >/dev/null 2>&1 || 
  echo "https://github.com/Homebrew/brew/releases/download/4.2.3/Homebrew-4.2.3.pkg" || 
  echo "after installing Homebrew run this command again." || 
  exit 1
  

if [[ "${OS}" == "Darwin" ]]
then
  echo "we are on macos"
fi
case "${SHELL}" in
  */bash*)
    shell_rcfile="${HOME}/.bash_profile"
    ;;
  */zsh*)
    shell_rcfile="${ZDOTDIR:-"${HOME}"}/.zprofile"
    ;;
  */fish*)
    shell_rcfile="${HOME}/.config/fish/config.fish"
    ;;
  *)
    shell_rcfile="${ENV:-"${HOME}/.profile"}"
    ;;
esac

echo ${shell_rcfile}

# script dependencies
# brew install wget

ring_bell