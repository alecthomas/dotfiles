#!/bin/zsh

# Format file completion with LS_COLORS
eval $(dircolors ~/.dircolors)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
