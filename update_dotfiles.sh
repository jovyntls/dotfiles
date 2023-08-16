#!/bin/bash

# vim 
cp -r $HOME/.config/nvim .
# zsh
cp $HOME/.zshrc ./zsh
cp -r $HOME/.oh-my-zsh/custom ./zsh
# kitty
cp -r $HOME/.config/kitty .
# amethyst config file
cp $HOME/.amethyst.yml ./misc
# for specifying latex build files
cp $HOME/.latexmkrc ./misc
# editor settings
cp ~/Library/Application\ Support/Code/User/settings.json ./vscode/
# obsidian vimrc
cp ~/Obsidian/obsidian-workspace/.obsidian.vimrc ./misc
# daily scripts
cp -r ~/do-not-move/scripts/ ./scripts
crontab -l > ./scripts/crontabs
