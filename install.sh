#!/bin/bash

set -u

# -------------------------
# string formatters
tty_escape() {
  printf "\033[%sm" "$1";
}

tty_reset="$(tty_escape 0)"
tty_bold="$(tty_escape 1)"
tty_underline="$(tty_escape 4)"
tty_invert="$(tty_escape 7)"

tty_grey="$(tty_escape 30)"
tty_red="$(tty_escape 31)"
tty_green="$(tty_escape 32)"
tty_yellow="$(tty_escape 33)"
tty_blue="$(tty_escape 34)"
tty_magenta="$(tty_escape 35)"
tty_cyan="$(tty_escape 36)"
tty_silver="$(tty_escape 37)"

# -------------------------
# log messages
log_step() {
  printf "\n${tty_bold}${tty_blue}==> %s${tty_reset}\n" "$@"
}

log_ok() {
  printf "${tty_bold}${tty_green}\xE2\x9C\x94 ${tty_reset} %s\n" "$@"
}

log_err() {
  printf "${tty_red}%s${tty_reset}\n" "$@"
}

log_url() {
  printf "${tty_blue}${tty_underline}%s${tty_reset}\n" "$@"
}

# -------------------------
# Terminate with an error message.
abort() {
  printf "${tty_red}%s\n" "$@" >&2
  printf "\a"
  exit 1
}

# -------------------------
# Make sure we are on macos.
log_step "Checking Operating System:"
OS="$(uname)"
if [[ "${OS}" == "Darwin" ]]
then
  log_ok "MacOS detected."
else
  abort "This installation is only for MacOS."
fi

# -------------------------
# Make sure XCode is installed
log_step "Checking xcode:"
xcode-select --install
log_ok "xcode is installed."

# -------------------------
# Make sure we have Conda installed.
log_step "Checking Conda:"
# Check Conda executive.
if ! command -v conda >/dev/null
then
  log_err "Conda is not installed."
  log_err "Please install Conda and execute this bash file again."
  echo ""
  log_err "Download and install Conda here:"
  log_url "https://docs.conda.io/projects/miniconda/en/latest/"
  abort ""
else
  log_ok "you have Conda installed."
fi

# -------------------------
# Make sure we have XQuartz installed.
log_step "Checking XQuartz:"
# Check XQuartz executive.
if ! command -v xquartz >/dev/null
then
  log_err "XQuartz is not installed."
  log_err "Please install XQuartz and execute this bash file again."
  echo ""
  log_err "Download and install XQuartz here:"
  log_url "https://github.com/XQuartz/XQuartz/releases/download/XQuartz-2.8.5/XQuartz-2.8.5.pkg"
  abort ""
else
  log_ok "you have XQuartz installed."
fi

# -------------------------
# Make sure we have Homebrew installed.
log_step "Checking Homebrew:"

# Determine Homebrew prefix based on machine architecture.
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "${UNAME_MACHINE}" == "arm64" ]]
then
  # On ARM macOS, Homebrew is installed in /opt/homebrew only
  HOMEBREW_PREFIX="/opt/homebrew"
else
  # On Intel macOS, Homebrew is installed in /usr/local only
  HOMEBREW_PREFIX="/usr/local"
fi

# Check Homebrew executive.
if ! command -v $HOMEBREW_PREFIX/bin/brew >/dev/null
then
  log_err "Homebrew is not installed."
  log_err "Please install Homebrew and execute this bash file again."
  echo ""
  log_err "Download and install Homebrew here:"
  log_url "https://github.com/Homebrew/brew/releases/download/4.2.3/Homebrew-4.2.3.pkg"
  abort ""
else
  log_ok "you have Homebrew installed."
fi

# Determine shell_rcfile
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

# Add Homebrew to the PATH.
if grep -qs "eval \"\$(${HOMEBREW_PREFIX}/bin/brew shellenv)\"" "${shell_rcfile}"
then
  if ! [[ -x "$(command -v brew)" ]]
  then
    eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
  fi
  log_ok "Homebrew is in the PATH."
else
  (echo; echo "eval \"\$(${HOMEBREW_PREFIX}/bin/brew shellenv)\"") >> ${shell_rcfile}
  eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
  log_ok "Homebrew is added to the PATH."
fi

# -------------------------
# Install Xquartz & Fox
log_step "Install Homebre Dependencies:"
brew update
brew install fox










