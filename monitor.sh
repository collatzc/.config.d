#!/bin/bash

# Mode: S-ingle D-ual 1-st 2-nd AUTO-detect
MONMODE=${1:-S}

MONITOR=(`xrandr | grep "\sconnected" | cut -d ' ' -f 1`)
MONITORNO="${#MONITOR[@]}"
echo "There are ${MONITORNO} monitor(s) be found:"
printf '%s\n' "${MONITOR[@]}"
if [ "$MONITORNO" = "1" ]; then
	xrandr --output "${MONITOR[0]}" --primary --mode 1920x1080 --output "VIRTUAL1" --off
	echo "There is only one monitor!"
	echo "Fin"
	exit 1
fi

case "$MONMODE" in
	"S4K")
		xrandr --dpi 192
		#xrandr --output "${MONITOR[1]}" --mode 2560x1440 --primary --output "${MONITOR[0]}" --off
		xrandr --output "${MONITOR[1]}" --mode 3840x2160 --scale 0.8x0.8 --primary --output "${MONITOR[0]}" --off
		feh --bg-scale ~/Images/bg.jpg
		;;
	"S1")
		xrandr --output "${MONITOR[0]}" --mode 1920x1080 --primary
		feh --bg-scale ~/Images/bg.jpg
		;;
	"S2")
		xrandr --output "${MONITOR[2]}" --mode 1920x1080 --output "${MONITOR[0]}" --off --output "${MONITOR[1]}" --off
		feh --bg-scale ~/Images/bg.jpg
		;;
	"DL")
		xrandr --output "${MONITOR[1]}" --auto --output "${MONITOR[0]}" --auto --primary --right-of "${MONITOR[1]}"
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"DLR21")
		xrandr --output "${MONITOR[1]}" --mode 1920x1080 --primary --output "${MONITOR[2]}" --mode 1920x1080 --right-of "${MONITOR[1]}" --output "${MONITOR[0]}" --off
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"DRL21")
		xrandr --output "${MONITOR[1]}" --mode 1920x1080 --output "${MONITOR[2]}" --mode 1920x1080 --left-of "${MONITOR[1]}" --output "${MONITOR[0]}" --off
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"TL21")
		xrandr --output "${MONITOR[1]}" --auto --output "${MONITOR[2]}" --auto --right-of "${MONITOR[1]}" --output "${MONITOR[0]}" --auto --right-of "${MONITOR[2]}"
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"DR")
		xrandr --output "${MONITOR[0]}" --auto --primary --output "${MONITOR[1]}" --mode 1920x1080 --right-of "${MONITOR[0]}"
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"TM21")
		xrandr --output "${MONITOR[2]}" --auto --output "${MONITOR[0]}" --auto --right-of "${MONITOR[2]}" --output "${MONITOR[1]}" --auto --right-of "${MONITOR[0]}"
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"TMTR12")
		xrandr --output "${MONITOR[0]}" --auto --output "${MONITOR[2]}" --auto --right-of "${MONITOR[0]}" --output "${MONITOR[1]}" --auto --above "${MONITOR[0]}"
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"DT")
		xrandr --output "${MONITOR[0]}" --mode 1920x1080 --primary --output "${MONITOR[1]}" --auto --above "${MONITOR[0]}"
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"DT4K")
		xrandr --output "${MONITOR[0]}" --mode 1920x1080 --primary --output "${MONITOR[1]}" --mode 3840x2160 --above "${MONITOR[0]}"
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"DB")
		xrandr --output "${MONITOR[0]}" --auto --primary --output "${MONITOR[1]}" --auto --below "${MONITOR[0]}"
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"S")
		xrandr --output "${MONITOR[1]}" --off --output "${MONITOR[0]}" --auto
		feh --bg-scale ~/Images/bg.jpg
		;;
	"AUTO")
		xrandr --auto
		feh --bg-scale ~/Images/bg.jpg
		;;
	"1")
		xrandr --output "${MONITOR[1]}" --mode 1920x1080 --output "${MONITOR[2]}" --off --output "${MONITOR[0]}" --off
		feh --bg-scale ~/Images/bg.jpg
		;;
	"2")
		xrandr --output "${MONITOR[2]}" --mode 1920x1080 --output "${MONITOR[1]}" --off --output "${MONITOR[0]}" --off
		feh --bg-scale ~/Images/bg.jpg
		;;
esac

echo "Fin"
