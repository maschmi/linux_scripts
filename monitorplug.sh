#!/bin/bash
# inspired by https://frdmtoplay.com/i3-udev-xrandr-hotplugging-output-switching/
set -e

USBC_STATUS=$(</sys/class/drm/card1-DP-1/status )

if [ ! -f /tmp/monitor ]; then
	touch /tmp/monitor
	STATE=0
else
	STATE=$(</tmp/monitor )
fi

# STATE 1 = USBC only
# STATE 0 = Auto
if [ "disconnected" == "$USBC_STATUS" ]; then
	STATE=0
fi

echo $STATE
case $STATE in
	0)
	/usr/bin/xrandr --auto
	/usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "External monitor disconnected"	
	STATE=1
	;;
	1)
	if [ "connected" == "$USBC_STATUS" ]; then
		/usr/bin/xrandr --output DP-1 --output eDP-1-1 --off
		/usr/bin/notify-send --urgency=low -t 5000 "Graphics Update" "USBC plugged in"
	fi
	STATE=0
	;;
esac

echo "Write $STATE"
echo $STATE > /tmp/monitor
