[[ $- != *i* ]] && return

function sourceif() {
  [ -e $1 ] && source $@ || true
}

function evalif() {
  type $1 >/dev/null 2>&1 && eval "$2" || true
}

function mkcd() {
  mkdir "$1"
  cd "$1"
}

function recd() {
  cd "$PWD"
}

export PATH=$PATH:$HOME/.local/bin
evalif nvim 'export VISUAL=nvim'
evalif vim 'export VISUAL=vim'
export EDITOR=$VISUAL

alias ls='ls --color=auto'
alias la='ls -la'
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -ch'
alias unansi='sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"'

bind '"jj": vi-movement-mode'

readonly COLOR_RED="\[$(tput setaf 1)\]"
readonly COLOR_GREEN="\[$(tput setaf 2)\]"
readonly COLOR_BLUE="\[$(tput setaf 4)\]"
readonly COLOR_PURPLE="\[$(tput setaf 5)\]"
readonly COLOR_RESET="\[$(tput sgr0)\]"

function prompt {
  local -r exit_code=$?
  local start_color
  if [ $exit_code -eq 0 ]; then
    start_color=$COLOR_PURPLE
  else
    start_color=$COLOR_RED
  fi
  PS1="\n$COLOR_BLUE\u@\h \w\n$start_color❯$COLOR_RESET "
}

PROMPT_COMMAND='prompt'
