#!/bin/sh

brew install fish

# sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
sudo ln -s /opt/homebrew/bin/fish /usr/local/bin/fish
chsh -s /usr/local/bin/fish
fish_add_path /opt/homebrew/bin
fish_update_completions
