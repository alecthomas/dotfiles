if [ -f /etc/profile ]; then
  source /etc/profile
fi

export FPATH=~/.zsh/completion:$FPATH

autoload colors zsh/terminfo
colors

# Format file completion with LS_COLORS
eval $(dircolors -b)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Ignore these extensions during tab completion
fignore=('.pyc' '.sw?')

PROMPT='[%n@%B%m%b:%~]'

# press M-CR to accept and keep the completion going
bindkey '\e^M' accept-and-menu-complete
# The VI variants refuse to backspace over existing text. This is shit.
bindkey '^?' backward-delete-char
bindkey '^W' backward-kill-word
# Ctrl-E to launch line editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line


unsetopt beep

alias vi=vim
alias ls='ls --color=auto -F --ignore="*.pyc" --ignore="*~"'
alias less='less -R'

# Set xterm title
XTITLE="%n@%m:%~"
precmd() {
  test -t 1 || return
  case $TERM in
    xterm*|rxvt*)
      print -Pn "\e]2;$XTITLE\a"
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
  PROMPT="[%n@%B%m%b:$DIR]"
}

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
setopt auto_cd
setopt append_history
setopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt hist_no_functions
setopt no_hist_beep
setopt hist_save_no_dups
setopt magic_equal_subst
setopt nohup

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
  /usr/bin/find ${2-.} -name $1
}

# g <regex> [<path>
g() {
  /bin/grep -rIE $1 ${2-.}
}

if [ -r ~/.zshrc-local ]; then
  . ~/.zshrc-local
fi
