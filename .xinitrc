xrandr --dpi 210

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN;en_US
export LC_CTYPE=en_US.UTF-8

export QT_AUTO_SCREEN_SCALE_FACTOR=1.5
export GDK_SCALE=1.5
#export ELM_SCALE=1.33

# redshift
pgrep redshift &> /dev/null || redshift &> /dev/null &

# enable custom keybinding
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

exec i3
