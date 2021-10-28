# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# for Go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/jovyntan/.oh-my-zsh"

# crontab uses this to determine which editor
export EDITOR=/usr/local/bin/vim

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="mh"
precmd() { print "" }

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# ALIASES
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias fvf='vim "$(fzf)"'

# navigation aliases
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias wk="cd ~/Desktop/work && ls"
alias cdc="cd ~/Desktop/code-stuff && tree -L 1"
alias cdcs="cd ~/Desktop/NUS/cheatsheets"
alias ref="cd ~/Desktop/code-stuff/references && tree -L 1"
alias tree1="tree -L 1"
alias tree2="tree -L 2 -I node_modules && echo '\n(node_modules ignored)'"
alias tree3="tree -L 3 -I node_modules && echo '\n(node_modules ignored)'"

alias cleardl="sh ~/Desktop/code-stuff/useful/clear-downloads/clear-downloads.sh"

alias chr="open -n -a 'Google Chrome' --args --profile-directory='Default'"
alias chrn="open -n -a 'Google Chrome' --args --profile-directory='Profile 5'"

# NUS aliases
alias ffmplay="/Applications/ffmpeg-4.3-macos64-static/bin/ffplay ~/Desktop/ffmpeg-recording*.mp4"
alias checkstyle="java -jar ~/Documents/cs2030s/bin/checkstyle.jar -c ~/Documents/cs2030s/bin/cs2030_checks.xml *.java"
alias sunfire="ssh jovyntls@sunfire.comp.nus.edu.sg"

# aliases for development
alias gdf="git difftool --tool=vimdiff -y HEAD"
alias bers="bundle exec rails s"
alias berc="bundle exec rails c"
alias ber="bundle exec rails"
alias yst="yarn start"
alias ysv="yarn serve"

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function cl() {
	cal "$1" $(date +"%Y")
}

function cdl() {
    cd "$1" && ls .
}

function ccc() {
	# C++ output
	cc "$1"
    ./a.out
    echo $?
}

function datacheck() {
	cd ~/PycharmProjects/learning_python/aimz_projects
	code -n .
	code ./table_generators/googlesheet_template.py
	cd
}

function ffmrecord() {
	/Applications/ffmpeg-4.3-macos64-static/bin/ffmpeg -f avfoundation -r 1 -probesize 20M -threads 1 -i "1:" -vcodec libx264 -b:v 128k -s hd720 ~/Desktop/ffmpeg-recording-$(timestamp).mp4
	print "Recording stopped at "$(timestamp)
}

function timestamp() {
	date +"%d-%m-%Y_%H.%M.%S"
}

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
eval "$(rbenv init -)"

# for pyenv 
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# for nodenv
eval "$(nodenv init -)"
