#!/bin/sh
rm ~/.is_presentation 2> /dev/null
xrandr --output DP-2-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output DP-2-2 --off --output DP-2-3 --off --output eDP-1 --mode 1920x1080 --pos 3840x1079 --rotate normal --output HDMI-2 --off --output HDMI-1 --off --output DP-2 --off --output DP-1 --off
xrandr --output eDP-1 --scale 1x1
i3-msg restart
