#!/bin/sh

setup() {
  [ "$#" -eq 0 ] && freq="120" || freq="$1"
  xrandr --output DisplayPort-0 --mode 2560x1440 --rate "$freq" --set TearFree on
  xrandr --output HDMI-A-0 --mode 2560x1440 --rate 60 --set TearFree on
  xrandr --output HDMI-A-0 --right-of DisplayPort-0
}

toggle() {
  local mons=$(xrandr --listmonitors | head -n 1)
  mons="${mons:10}"
  if [[ "$mons" -eq "1" ]]; then
    setup 
  else
    xrandr --output HDMI-A-0 --off
  fi
}

if [[ $# -eq 0 ]]; then
  setup
elif [[ "$1" == "--toggle" ]]; then
  toggle
else
  setup $1
fi
