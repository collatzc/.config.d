export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN;en_US
export LC_CTYPE=en_US.UTF-8

# redshift
pgrep redshift &> /dev/null || redshift &> /dev/null &

# enable custom keybinding
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
# color theme
[[ -f ~/.Xresources ]] && xrdb -load -I$HOME ~/.Xresources

exec i3
