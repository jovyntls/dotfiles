#!/bin/bash
cd ~/Obsidian/obsidian-workspace

if [ -d .git ]; then
  if [[ `git status --porcelain` ]]; then
    git add .
    git commit -m "`date +'%Y-%m-%d %p'`" 
    git push
  fi
else
  echo "not a git repository!"
fi;

cd ~/Obsidian/personal

if [ -d .git ]; then
  if [[ `git status --porcelain` ]]; then
    git add .
    git commit -m "`date +'%Y-%m-%d %p'`" 
    git push
  fi
else
  echo "not a git repository!"
fi;

