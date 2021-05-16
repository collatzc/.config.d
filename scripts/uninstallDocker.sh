#!/bin/bash

sudo rm -rf /Library/PrivilegedHelperTools/com.docker.vmnetd
sudo rm -rf /Library/LaunchDaemons/com.docker.vmnetd.plist
sudo rm -rf /usr/local/lib/docker
rm -rf ~/.docker
rm -rf "~/Library/Application Support/Docker Desktop"
rm -rf ~/Library/Preferences/com.docker.docker.plist
rm -rf ~/Library/Group Containers/group.com.docker
rm -rf "~/Library/Logs/Docker Desktop"
rm -rf ~/Library/Preferences/com.electron.docker-frontend.plist
rm -rf ~/Library/Cookies/com.docker.docker.binarycookies
