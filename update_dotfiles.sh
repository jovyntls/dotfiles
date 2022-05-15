#!/bin/bash

# vim 
cp ~/.vimrc ./vim
cp ~/.vim/UltiSnips/tex.snippets ./vim
cp -r ~/.config/nvim .
# zsh
cp ~/.zshrc ./zsh
cp ~/.oh-my-zsh/themes/mh.zsh-theme ./zsh
# kitty
cp -r ~/.config/kitty .
# for specifying latex build files
cp ~/.latexmkrc ./misc
# editor settings
cp ~/Library/Application\ Support/Code/User/settings.json ./vscode/
# obsidian vimrc
cp ~/Obsidian/obsidian-workspace/.obsidian.vimrc ./misc
# daily scripts
cp -r ~/do-not-move/scripts/ ./scripts
crontab -l > ./scripts/crontabs
