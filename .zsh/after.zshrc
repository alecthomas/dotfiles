export MAKEFLAGS=-j12
export GLOG_logtostderr=1

export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT=/Users/alec/bin/cocos2d-x-3.2alpha0/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
