#!/bin/bash

###
# Script to install dep
# @see https://github.com/golang/dep
###

if [ -d "${HOME}/go/bin" ]; then
	# download the release v0.3.2
	wget https://github.com/golang/dep/releases/download/v0.3.2/dep-linux-amd64 -O "${HOME}/go/bin/dep-linux-amd64"
	# exec permit
	chmod +x "${HOME}/go/bin/dep-linux-amd64"
	case `uname` in
		"Darwin")
			;;
		"Linux")
			sudo ln -s "${HOME}/go/bin/dep-linux-amd64" /usr/local/bin/dep
			;;
	esac
fi
