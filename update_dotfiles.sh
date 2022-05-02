#!/bin/bash

# vim 
cp ~/.vimrc .
cp ~/.vim/UltiSnips/tex.snippets .
cp -r ~/.config/nvim .
# zsh
cp ~/.zshrc .
cp ~/.oh-my-zsh/themes/mh.zsh-theme .
# kitty
cp -r ~/.config/kitty .
# for specifying latex build files
cp ~/.latexmkrc .
# editor settings
cp ~/Library/Application\ Support/Code/User/settings.json ./vscode/
# obsidian vimrc
cp ~/Obsidian/obsidian-workspace/.obsidian.vimrc .
# daily scripts
cp -r ~/do-not-move/scripts/ ./scripts
crontab -l > ./scripts/crontabs
