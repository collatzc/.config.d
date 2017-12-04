#!/bin/bash

# assume is unter linux
USER=`whoami`
BASE_PATH="/home/${USER}/.config.d/"
# need to enter password
echo Installing...
sudo ln -s "${BASE_PATH}wttr" /usr/local/bin/wttr
sudo ln -s "${BASE_PATH}lognow" /usr/local/bin/lognow
echo Fin.
