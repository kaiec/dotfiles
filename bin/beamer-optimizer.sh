#!/bin/bash
beamer=$(xrandr | grep " connected" | grep -v eDP-1 | cut -d " " -f 1)
xrandr --output $beamer --auto --output eDP-1 --off --output DVI-I-1-1 --off
res=$(xrandr | grep $beamer | cut -d " " -f 3 | cut -d + -f 1)
xrandr --output eDP-1 --auto --scale-from $res --same-as $beamer
