export DPI=$(~/.config.d/scripts/getDPI.sh)
xrandr --dpi $DPI

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export LANG="en_US.UTF-8"
export LANGUAGE="zh_CN;en_US;de_DE"
export LC_CTYPE="en_US.UTF-8"

# redshift
pgrep redshift &> /dev/null || redshift &> /dev/null &

# enable custom keybinding
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# color theme
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

exec i3
#exec awesome
