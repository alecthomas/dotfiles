#!/bin/zsh

# Format file completion with LS_COLORS
eval $(dircolors -b)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
