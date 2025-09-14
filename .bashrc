[[ $- != *i* ]] && return

function sourceif() {
  [ -e $1 ] && source $@ || true
}

function evalif() {
  if type $1 >/dev/null 2>&1; then
    script=$("$@")
    eval "$script"
  fi
}

function mkcd() {
  mkdir "$1"
  cd "$1"
}

function recd() {
  cd "$PWD"
}

function t() {
  tmp=$(mktemp -d)
  pushd "$tmp" > /dev/null
  $SHELL -i
  popd > /dev/null
  rm -rf "$tmp"
}

evalif tmux-go completion
evalif direnv hook bash
sourceif "$HOME/.opam/opam-init/init.sh"
evalif rbenv init - --no-rehash bash
evalif fnm env --use-on-cd --version-file-strategy=recursive --shell=bash

alias l='ls --color=auto'
alias la='l -la'
alias unansi='sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"'

bind '"jj": vi-movement-mode'

readonly COLOR_RED="\[$(tput setaf 1)\]"
readonly COLOR_GREEN="\[$(tput setaf 2)\]"
readonly COLOR_BLUE="\[$(tput setaf 4)\]"
readonly COLOR_PURPLE="\[$(tput setaf 5)\]"
readonly COLOR_GRAY="\[$(tput setaf 8)\]"
readonly COLOR_RESET="\[$(tput sgr0)\]"

function prompt {
  local -r exit_code=$?
  local start_color
  if [ $exit_code -eq 0 ]; then
    start_color=$COLOR_PURPLE
  else
    start_color=$COLOR_RED
  fi
  PS1="$COLOR_GRAY\D{%FT%T%z}\n$COLOR_BLUE\u@\h \w\n$start_color\$$COLOR_RESET "
}

PROMPT_COMMAND="$PROMPT_COMMAND; prompt"
