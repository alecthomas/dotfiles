#!/bin/zsh

if [ -f /etc/profile ]; then
  . /etc/profile
fi

if [ -r ~/.zsh/zshrc.before ]; then
  . ~/.zsh/zshrc.before
fi

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

autoload colors zsh/terminfo
colors

# Ignore these extensions during tab completion
fignore=('.pyc' '.sw?' '.6' '.8')

# press M-CR to accept and keep the completion going
bindkey '\e^M' accept-and-menu-complete
# The VI variants refuse to backspace over existing text. This is shit.
bindkey '^?' backward-delete-char
bindkey '^W' backward-kill-word
# Ctrl-E to launch line editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line
# Insert the last word from the previous line.
bindkey "^P" insert-last-word

source ~/.zsh/plugins/git-flow-completion.zsh

# Automatically quote meta-characters in URLs!
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

unsetopt beep

alias vi='vim -X'
alias ls='ls --color=auto -F --ignore="*.pyc" --ignore="*~"'
alias less='less -R'

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
  if [ $DIR != "~" -a $DIR != "/" ]; then
    local BASE=$(basename $DIR)
    DIR=$(dirname $DIR)
    DIR=$(echo "$DIR" | sed -e 's#/\(.\)[^/]\+#/\1#g')
    if [ -n $BASE ]; then
        DIR=$DIR/$BASE
    fi
    DIR=${DIR//\/\///}
  fi
  psvar[1]=$DIR
  psvar[2]=$#jobstates
  test $psvar[2] -eq 0 && psvar[2]=()
}

PROMPT="%(2v:<+%2v>:)[%n@%B%m%b:%1v]"

which todo > /dev/null 2>&1
HAVE_TODO=$?
which ondir > /dev/null 2>&1
HAVE_ONDIR=$?

if [ $HAVE_TODO = 0 -o $HAVE_ONDIR = 0 ]; then
    TODO_OPTIONS="--timeout 5 --timeout --summary"
    chpwd() {
      [ -t 1 ] || return
      [ $HAVE_TODO = 0 -a -r .todo ] && todo ${=TODO_OPTIONS}
      [ $HAVE_ONDIR = 0 ] && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
    }
    chpwd
fi


umask 0027

expand-or-complete-with-dots() {
  echo -n "${fg[red]}...${terminfo[sgr0]}"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
bindkey "^R" history-incremental-search-backward

HISTSIZE=10000
SAVEHIST=10000
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

# f <glob> [<path>]
f() {
  find ${2-.} ! -path '*/.git/*' ! -path '*/.venv*' ! -name '*.log*' -iname \*${1-\*}\*
}

# g <regex> [<path>]
g() {
  grep -iIE $1 $(f \* ${2-.})
}

if [ -r ~/.zsh/$(uname).zshrc ]; then
  . ~/.zsh/$(uname).zshrc
fi

if [ -r ~/.zsh/zshrc.after ]; then
  . ~/.zsh/zshrc.after
fi
