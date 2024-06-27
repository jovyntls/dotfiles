open_tex() {
  tex_files=$(ls | grep "\.tex$" | wc -l)
  if (( tex_files > 3 )); then
    echo "Multiple .tex files found:"
    ls | grep "\.tex$"
  else
    nvim -O *.tex
  fi
}

# ALIASES --------------------------------------------------------

# general
alias vimrc="cd ~/.config/nvim && nvim ~/.config/nvim/init.lua"
alias zshrc="cd $ZSH_CUSTOM && nvim ~/.zshrc"
alias fvf='nvim -c :Files'
alias faf='nvim -c :Ag'
alias vi='nvim'
alias vig='nvim +G +only'
alias vit=open_tex
alias kssh="kitty +kitten ssh"
alias cpwd="echo -n `pwd` | pbcopy"

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
alias pip="pip3"
alias py="python3"
alias python="python3"

# navigation
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias cdc="cd ~/Desktop/code-stuff && tree -L 1"
alias cdcs="cd ~/Desktop/my-documents/school/NUS/cheatsheets"
alias ref="cd ~/Desktop/code-stuff/references && tree -L 1"

alias ap="cd ~/Desktop/not\ work/aphrodite-monorepo"

