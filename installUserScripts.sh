#!/bin/bash

###
# Script to install some widgets
# 
# List:
# - wttr: To check weather
# - lognow: To make a diary
###

BASE_PATH="${HOME}/.config.d"

echo Installing...

if [[ `uname` == 'Darwin' ]]; then
	ln -s "${BASE_PATH}/wttr" /usr/local/bin/wttr
	ln -s "${BASE_PATH}/lognow" /usr/local/bin/lognow
else
# need to enter password
	sudo ln -s "${BASE_PATH}/wttr" /usr/local/bin/wttr
	sudo ln -s "${BASE_PATH}/lognow" /usr/local/bin/lognow
fi

echo Fin.
