#!/bin/bash

# vim 
cp ~/.vimrc .
cp ~/.vim/UltiSnips/tex.snippets .
# zsh
cp ~/.zshrc .
cp ~/.oh-my-zsh/themes/mh.zsh-theme .
# for specifying latex build files
cp ~/.latexmkrc .
# editor settings
cp ~/Library/Application\ Support/Code/User/settings.json ./vscode/
# daily scripts
cp -r ~/do-not-move/scripts .
crontab -l > crontabs
