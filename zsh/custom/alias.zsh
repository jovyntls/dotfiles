# ALIASES --------------------------------------------------------

# general
alias vimrc="cd ~/.config/nvim && nvim ~/.config/nvim/init.lua"
alias zshrc="cd $ZSH_CUSTOM && nvim ~/.zshrc"
alias fvf='nvim -c :Files'
alias faf='nvim -c :Ag'
alias vi='nvim'
alias vig='nvim +G +only'
alias kssh="kitty +kitten ssh"

# for development
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
alias py="python3"

# navigation
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias cdc="cd ~/Desktop/code-stuff && tree -L 1"
alias cdcs="cd ~/Desktop/school/cheatsheets"
alias ref="cd ~/Desktop/code-stuff/references && tree -L 1"

# NUS 
alias checkstyle="java -jar ~/Documents/cs2030s/bin/checkstyle.jar -c ~/Documents/cs2030s/bin/cs2030_checks.xml *.java"
alias sunfire="ssh jovyntls@sunfire.comp.nus.edu.sg"
alias ffmplay="/Applications/ffmpeg-4.3-macos64-static/bin/ffplay ~/Desktop/ffmpeg-recording*.mp4"
# semesterly aliases
alias mbsd="markbind serve -d"
alias wk="cd ~/Desktop/work"

