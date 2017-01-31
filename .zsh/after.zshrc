#!/bin/zsh

alias vi=vim
alias grep='ggrep --color=auto'

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
