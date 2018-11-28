xrandr --dpi 210

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"


export QT_AUTO_SCREEN_SCALE_FACTOR=1.5
export GDK_SCALE=1.5
#export ELM_SCALE=1.33

# redshift
pgrep redshift &> /dev/null || redshift &> /dev/null &

# enable custom keybinding
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

exec i3
