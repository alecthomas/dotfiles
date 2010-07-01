#!/bin/bash

root=~/.dotfiles
dotfiledir=$(basename $root)

# Sync new dotfiles
for dotfile in ${root}/.*; do
    filename=$(basename "$dotfile")
    if [[ "$filename" != . && "$filename" != .. && "$filename" != .gitignore \
        && "$filename" != .git && "$filename" != .*.sw? ]]; then
        if [ ! -L ~/$filename ]; then
            echo "ln -sf $dotfiledir/$filename ~/"
        fi
    fi
done

# Clean up old dotfiles
for dotfile in ~/.*; do
    if [ -L "$dotfile" -a ! -e "$dotfile" ]; then
        link=$(readlink "$dotfile")
        if [[ $link == *$dotfiledir* ]]; then
            echo "rm -f $dotfile   # symlinked to missing $link"
        fi
    fi
done
