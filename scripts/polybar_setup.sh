#!/bin/sh

killall -q polybar
MONITOR="DisplayPort-0" TRAY_POS=right polybar --reload bar &&
  [ "$(polybar --list-monitors| wc -l)" -eq 2 ] && MONITOR="HDMI-A-0" TRAY_POS=none polybar --reload bar &
