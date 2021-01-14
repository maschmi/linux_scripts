#! /bin/bash
# Small helper script to setup xrandr when using my work machine with different displays.

AUTO=0
PLACE="--right-of"
BUILDIN="eDP-1-1"

while getopts shcdrl flag
do
    case "${flag}" in
        a) AUTO=1;;
        h) MONITOR="HDMI-0";;
        c) MONITOR="DP-0";;
        d) MONITOR="DP-1";;
        r) ;;
        l) PLACE="--left-of"
    esac
done

if (( $AUTO > 0)); then
  xrandr --output $BUILDIN
  exit
fi

if [ -z "$MONITOR" ]; then
    xrandr --auto
else
    xrandr --output $MONITOR --auto $PLACE $BUILDIN
fi
