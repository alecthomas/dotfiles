#!/bin/zsh

fpath=(/usr/local/share/zsh/site-functions $fpath)
export JAVA_HOME=$(/usr/libexec/java_home 2> /dev/null)

# Format file completion with LS_COLORS
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;33:*.bat=01;32:*.BAT=01;32:*.btm=01;32:*.BTM=01;32:*.cmd=01;32:*.CMD=01;32:*.com=01;32:*.COM=01;32:*.dll=01;32:*.DLL=01;32:*.exe=01;32:*.EXE=01;32:*.arj=01;31:*.bz2=01;31:*.deb=01;31:*.gz=01;31:*.lzh=01;31:*.rpm=01;31:*.tar=01;31:*.taz=01;31:*.tb2=01;31:*.tbz2=01;31:*.tbz=01;31:*.tgz=01;31:*.tz2=01;31:*.z=01;31:*.Z=01;31:*.zip=01;31:*.ZIP=01;31:*.zoo=01;31:*.asf=01;35:*.ASF=01;35:*.avi=01;35:*.AVI=01;35:*.bmp=01;35:*.BMP=01;35:*.flac=01;35:*.FLAC=01;35:*.gif=01;35:*.GIF=01;35:*.jpg=01;35:*.JPG=01;35:*.jpeg=01;35:*.JPEG=01;35:*.m2a=01;35:*.M2a=01;35:*.m2v=01;35:*.M2V=01;35:*.mov=01;35:*.MOV=01;35:*.mp3=01;35:*.MP3=01;35:*.mpeg=01;35:*.MPEG=01;35:*.mpg=01;35:*.MPG=01;35:*.ogg=01;35:*.OGG=01;35:*.ppm=01;35:*.rm=01;35:*.RM=01;35:*.tga=01;35:*.TGA=01;35:*.tif=01;35:*.TIF=01;35:*.wav=01;35:*.WAV=01;35:*.wmv=01;35:*.WMV=01;35:*.xbm=01;35:*.xpm=01;35:*.cpp=00;32:*.c=00;32:*.cc=00;32:*.C=00;32:*.h=01;32:*.H=01;32:*.hpp=01;32:*.hh=01;32:'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Case insensitive completion on Mac
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
alias ls='ls -FG'
# This is the most stupid thing ever. Default behaviour is sort by PID??!? What the fuck BSD?
alias top='top -u'
function mvim() {
  local args
  if [ $# -ne 0 ]; then
    args="--remote-tab-silent"
  fi
  ~/bin/mvim $args $@
}
# Fix shitty ps. Probably other commands.
export COMMAND_MODE=unix2003
export MANPATH=/usr/local/man:
path=(~/bin /usr/local/bin /usr/local/sbin /usr/local/share/npm/bin $path)

export EDITOr='subl -nw'

# Adds some homebrew custom commands, in particular "brew linkapps"
if which brew &> /dev/null; then
  path=($(brew --repository)/share/npm/bin $(brew --repository)/Library/Contributions/examples $path)
  #export PYTHONPATH=/Library/Python/2.7/site-packages:$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH
fi

# Remove non-existant directories
path=($^path(N))

if [ -d ~/.go ]; then
  export GOPATH=~/.go
  path=(~/.go/bin $path)
fi


g() {
  if [ -z "$1" ]; then
    echo "usage: g <query> [<dir>]"
    return 1
  fi
  mdfind -onlyin "${2:-$PWD}" "$1"
}

f() {
  local pattern="$1"
  local dir="${2:-$PWD}"
  if [ -z "$pattern" ]; then
    find "$dir" -type f
    return 0
  elif [ -z "$dir" ]; then
    if [ -d "$pattern" ]; then
      dir="$pattern"
      unset pattern
    fi
  fi
  if [ -z "$pattern" ]; then
    find "$dir" -type f
  else
    find "$dir" -path "*$pattern*" -type f
  fi
}

export GITROOT=$HOME/development

alias grep='ggrep'
alias sed='gsed'
alias find='gfind'
