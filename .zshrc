# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/jovyntan/.oh-my-zsh"

# crontab uses this to determine which editor
export EDITOR=/usr/local/bin/vim

ZSH_THEME="mh"

# PLUGINS
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ALIASES
alias vimrc="nvim ~/.vimrc"
alias zshrc="nvim ~/.zshrc"
alias fvf='nvim -c :Files'
alias faf='nvim -c :Ag'
alias vi='nvim'

# navigation aliases
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias cdwk="cd ~/Desktop/work"
alias wk="cdwk && ls"
alias cdc="cd ~/Desktop/code-stuff && tree -L 1"
alias cdcs="cd ~/Desktop/NUS/cheatsheets"
alias ref="cd ~/Desktop/code-stuff/references && tree -L 1"

# NUS aliases
alias ffmplay="/Applications/ffmpeg-4.3-macos64-static/bin/ffplay ~/Desktop/ffmpeg-recording*.mp4"
alias checkstyle="java -jar ~/Documents/cs2030s/bin/checkstyle.jar -c ~/Documents/cs2030s/bin/cs2030_checks.xml *.java"
alias sunfire="ssh jovyntls@sunfire.comp.nus.edu.sg"
# exams record function
function ffmrecord() {
  /Applications/ffmpeg-4.3-macos64-static/bin/ffmpeg -f avfoundation -r 1 -probesize 20M -threads 1 -i "1:" -vcodec libx264 -b:v 128k -s hd720 ~/Desktop/ffmpeg-recording-$(timestamp).mp4
  print "Recording stopped at "$(timestamp)
}
# semesterly aliases
alias 3281="cdwk && cd CS3281 && ls"
alias 3230="cdwk && cd CS3230 && ls"
alias 2131="cdwk && cd ST2131 && ls"
alias edm="cdwk && cd UHB2214\ EDM && ls"
alias uqf="cdwk && cd UQF2101I && ls"
alias mb="cdwk && cd CS3281/markbind && ls"
alias mbsd="markbind serve -d"
alias atlasdb="PGPASSWORD=atlas_pw psql -h localhost -p 5433 -U atlas_user -d atlas_local"

# aliases for development
alias gcamend="git commit --amend --no-edit"
alias gdf="git difftool --tool=vimdiff -y HEAD"
alias ber="bundle exec rails"
alias bers="bundle exec rails s"
alias berc="bundle exec rails c"
alias nr="npm run"
alias yr="yarn run"
alias yst="yarn start"
alias ysv="yarn serve"
alias gpp="g++-11"

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

# for pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# added by NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

