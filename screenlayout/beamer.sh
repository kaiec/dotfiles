#!/bin/sh
xrandr --output DP-2-1 --off --output DP-2-2 --off --output DP-2-3 --off --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-2 --off --output HDMI-1 --mode 1920x1200 --pos 1920x0 --rotate normal --output DP-2 --off --output DP-1 --off
 xrandr --output eDP-1 --same-as HDMI-1 --output HDMI-1
 i3-msg restart
