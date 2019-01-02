#!/bin/bash

# Mode: S-ingle D-ual 1-st 2-nd AUTO-detect
MONMODE=${1:-AUTO}

MONITOR=(`xrandr | grep "\sconnected" | cut -d ' ' -f 1`)
MONITORNO="${#MONITOR[@]}"
echo "There are ${MONITORNO} monitor(s) be found."
if [ "$MONITORNO" = "1" ]; then
	xrandr --output "${MONITOR[0]}" --auto
	echo "There is only one monitor!"
	echo "Fin"
	exit
fi

case "$MONMODE" in
	"DL")
		xrandr --output "${MONITOR[1]}" --mode 1920x1080 --output "${MONITOR[2]}" --auto --primary --right-of "${MONITOR[1]}" --output "${MONITOR[0]}" --off
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"DR")
		xrandr --output "${MONITOR[0]}" --mode 1920x1080 --output "${MONITOR[1]}" --auto --primary --right-of "${MONITOR[0]}"
		feh --bg-scale ~/Images/bg.jpg --bg-scale ~/Images/bg.jpg
		;;
	"S")
		xrandr --output "${MONITOR[1]}" --off --output "${MONITOR[2]}" --off --output "${MONITOR[0]}" --auto
		feh --bg-scale ~/Images/bg.jpeg
		;;
	"AUTO")
		if [ "$MONITORNO" = "2" ]; then
			xrandr --output "${MONITOR[1]}" --mode 1920x1080 --output "${MONITOR[0]}" --auto --primary --right-of "${MONITOR[1]}"
			feh --bg-scale ~/Images/bg.jpeg
		else
			xrandr --output "${MONITOR[1]}" --mode 1920x1080 --output "${MONITOR[2]}" --auto --primary --right-of "${MONITOR[1]}" --output "${MONITOR[0]}" --off
			feh --bg-scale ~/Images/bg.jpeg --bg-scale ~/Images/bg.jpeg
		fi
		;;
	"1")
		xrandr --output "${MONITOR[1]}" --mode 1920x1080 --output "${MONITOR[2]}" --off --output "${MONITOR[0]}" --off
		feh --bg-scale ~/Images/bg.jpeg
		;;
	"2")
		xrandr --output "${MONITOR[2]}" --mode 1920x1080 --output "${MONITOR[1]}" --off --output "${MONITOR[0]}" --off
		feh --bg-scale ~/Images/bg.jpeg
		;;
esac


echo "Fin"
