#!/bin/sh

mkdir ~/.local/share/fonts
ln -s ~/.config.d/fonts/linux ~/.local/share/fonts/

if [ -f ~/.zshenv ]; then
  rm -rf ~/.zshenv
fi

sudo pacman -S zsh git curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew install zsh-syntax-highlighting zsh-autosuggestions

ln -s ~/.config.d/home/.zshrc ~/
