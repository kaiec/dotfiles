#!/bin/sh
#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
#polybar example &

# check if we have multiple mointors at position +0+0 -> projector
duplicated=$(xrandr --listactivemonitors | grep +0+0 | wc -l)
if [ $duplicated -eq 2 ]
then
	MONITOR=eDP-1 polybar example -c ~/.config/polybar/config
else
	# start bars on each monitor
	for i in $(polybar -m | awk -F: '{print $1}'); do MONITOR=$i polybar example -c ~/.config/polybar/config & done
fi
feh --bg-scale ~/.config/wall.png

echo "Bars launched..."
