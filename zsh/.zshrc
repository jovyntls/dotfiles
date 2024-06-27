# zmodload zsh/zprof

export PATH="/opt/homebrew/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# crontab uses this to determine which editor
export EDITOR=/usr/bin/vim

# for nvm lazy load
export NVM_LAZY_LOAD=true
# speed up start time
DISABLE_AUTO_UPDATE=true

ZSH_THEME="nicemh"

# PLUGINS
plugins=(git zsh-nvm)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/alias.zsh

# fzf
source <(fzf --zsh)

# utils
function cl() {
  cal "$1" $(date +"%Y")
}

function mkcd() {
  mkdir "$1" && cd "$1"
}

function timestamp() {
  date +"%d-%m-%Y_%H.%M.%S"
}

function tree1() {
  tree -L 1 $1
}

function tre() {
  # params: number of levels, folder to search
  tree -L $1 $2 -I node_modules
  echo '\n(node_modules ignored)'
}

# zprof
