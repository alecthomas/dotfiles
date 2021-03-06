#!/bin/zsh

ulimit -n 10000

if [ -f /etc/profile ]; then
  . /etc/profile
fi

if [ -r ~/.zsh/before.zshrc ]; then
  . ~/.zsh/before.zshrc
fi

# Magically link PYTHONPATH to the ZSH array pythonpath
typeset -T PYTHONPATH pythonpath
# Remove duplicates
typeset -U pythonpath path

export PYTHONPATH pythonpath

# Global aliases
alias -g L='|less'

# Use "run-help <builtin>" for help on zsh commands
autoload run-help
autoload complist

# Use completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# Allow
zstyle ':completion:*' menu select=1

export FPATH=~/.zsh/completion:$FPATH

export PYTHONDONTWRITEBYTECODE=1

if [ -d ~/.cabal/bin ]; then
  path+=~/.cabal/bin
fi

autoload colors zsh/terminfo
colors

# Ignore these extensions during tab completion
fignore=('.pyc' '.sw?' '.6' '.8')

# VI mode
bindkey -v
# press M-CR to accept and keep the completion going
bindkey '\e^M' accept-and-menu-complete
# The VI variants refuse to backspace over existing text. This is shit.
bindkey '^?' backward-delete-char
bindkey '^W' backward-kill-word
bindkey '\M-b' backward-word
bindkey '\M-f' forward-word
# Ctrl-E to launch line editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line
# Insert the last word from the previous line.
bindkey "^P" insert-last-word

# ^W delete to / rather than space.
#autoload -U select-word-style
#select-word-style bash
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Automatically quote meta-characters in URLs!
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

unsetopt beep
setopt rm_star_silent

alias ls='ls --color=auto -F --ignore="*.pyc" --ignore="*~"'
alias less='less -R'
alias u='cd "$(git rev-parse --show-toplevel)"'
alias gore='gore -autoimport'

# Set xterm title
XTITLE="%n@%m:%~"
precmd() {
  test -t 1 || return
  case $TERM in
    xterm*|rxvt*)
      print -Pn "\e]0;$XTITLE\a"
      ;;
  esac
  # Collapse the prompt path components to all first characters except the
  # last.
  local DIR=${PWD//#$HOME/\~}
#  if [ $DIR != "~" -a $DIR != "/" ]; then
#    DIR="$(echo "$DIR" | sed -e 's/[aeiou ]//g')"
#  fi
  psvar[1]="$DIR"
  psvar[2]="$#jobstates"
  test "$psvar[2]" -eq 0 && psvar[2]=()
}

PROMPT="%(2v:<+%2v>:)[%n@%B%m%b:%1v]"

which todo2 > /dev/null 2>&1
HAVE_TODO=$?
which ondir > /dev/null 2>&1
HAVE_ONDIR=$?

if [ $HAVE_TODO = 0 -o $HAVE_ONDIR = 0 ]; then
    alec_chpwd() {
      [ -t 1 ] || return
      [ $HAVE_TODO = 0 -a \( -r .todo -o -r .todo2 \) ] && todo2 --summary
      [ $HAVE_ONDIR = 0 ] && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
    }
    chpwd_functions+=("alec_chpwd")
    alec_chpwd
fi


umask 0027

expand-or-complete-with-dots() {
  echo -n "${fg[red]}...${terminfo[sgr0]}"
  zle expand-or-complete-prefix
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
bindkey "^R" history-incremental-search-backward

# Fuzzy completion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

HISTSIZE=100000
SAVEHIST=500000
HISTFILE=~/.zsh/history

# ZSH options
setopt auto_cd \
  auto_resume \
  append_history \
  complete_in_word \
  always_to_end \
  list_ambiguous \
  inc_append_history \
  extended_history \
  hist_find_no_dups \
  hist_ignore_all_dups \
  hist_reduce_blanks \
  hist_ignore_space \
  hist_no_store \
  hist_no_functions \
  no_hist_beep \
  hist_save_no_dups \
  magic_equal_subst \
  nohup \
  pushd_ignore_dups \
  pushd_silent \
  pushd_to_home

# Allow .'s after .. to refer to successively higher up directories
preexec() {
  setopt localoptions extendedglob
  if [[ -o autocd && $1 = ...# ]]
  then
    eval function $1 \{ cd ..${${1#..}:gs@.@/..}\; unfunction $1 \}
    alias -g $1="..${${1#..}:gs@.@/..}"
  fi
}

# Make git completion not shithouse
__git_files () {
    _wanted files expl 'local files' _files
}

READNULLCMD=${PAGER:-/bin/less}
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Add help for builtins
autoload run-help
alias help=run-help

# Configure auto-completion
autoload -U compinit
[[ -d "${ZDOTDIR:-$HOME}/.zcompdumps" ]] || mkdir -m 0700 -p "${ZDOTDIR:-$HOME}/.zcompdumps"
compinit -d "${ZDOTDIR:-$HOME}/.zcompdumps/${HOST%%.*}-$ZSH_VERSION"

#which fasd > /dev/null && eval "$(fasd --init auto)"

if [ -r ~/.zsh/$(uname).zshrc ]; then
  . ~/.zsh/$(uname).zshrc
fi

if [ -r ~/.zsh/after.zshrc ]; then
  . ~/.zsh/after.zshrc
fi
