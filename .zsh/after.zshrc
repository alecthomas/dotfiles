#!/bin/zsh

alias vi=vim
alias grep='ggrep --color=auto'
alias rg='rg --no-messages -n --no-heading -g "!**/vendor" -g "!**/*.pb.go"'

alias g=rg
# f <glob> [<path>]
f() {
  if [ -z "$1" ]; then
    rg --files .
  else
    rg -g "*${1}*" --files ${2-.}
  fi
}

export MAKEFLAGS=-j12
export GLOG_logtostderr=1

export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv

# If ".rvm" doesn't appear in $PATH load RVM
if [[ $PATH != *".rvm"* ]]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi


autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit
autoload -U bashcompinitfi

_substrate_bash_autocomplete() {
    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=$( ${COMP_WORDS[0]} --completion-bash ${COMP_WORDS[@]:1:$COMP_CWORD} )
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    [[ $COMPREPLY ]] && return
    compgen -f
    return 0
}
complete -F _substrate_bash_autocomplete substrate
