#!/bin/bash

root=~/.dotfiles
dotfiledir=$(basename $root)

# Sync new dotfiles
for dotfile in ${root}/.*; do
    filename=$(basename "$dotfile")
    if [ "$filename" != . -a "$filename" != .. -a "$filename" != .git ]; then
        if [ ! -e ~/$filename ]; then
            echo "ln -sf $dotfiledir/$filename ~/"
        fi
    fi
done

# Clean up old dotfiles
for dotfile in ~/.*; do
    if [ -L "$dotfile" -a ! -e "$dotfile" ]; then
        link=$(readlink "$dotfile")
        if [[ $link == *$dotfiledir* ]]; then
            echo "# $dotfile symlinked to missing $link"
            echo "rm -f $dotfile"
        fi
    fi
done
