#!/bin/sh

if [ "$#" -eq 0 ]; then
  freq="120"
else
  freq="$1"
fi

xrandr --output DisplayPort-0 --mode 2560x1440 --rate "$freq"
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60
xrandr --output HDMI-A-0 --right-of DisplayPort-0

