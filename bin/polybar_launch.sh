#!/usr/bin/env sh

echo "(Re) starting polybar" > ~/polybar.log

# Terminate already running bar instances
killall -q polybar

echo "Kill signal sent to running instances..." >> ~/polybar.log

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

echo "All killed..." >> ~/polybar.log

# Launch bar1 and bar2
#polybar example &

# check if we have multiple mointors at position +0+0 -> projector
duplicated=$(xrandr --listactivemonitors | grep +0+0 | wc -l)
echo "Duplicated: $duplicated" >> ~/polybar.log
if [ $duplicated -eq 2 ]
then
	echo "Starting single bar..." >> ~/polybar.log
	MONITOR=eDP-1 polybar example -c ~/.config/polybar/config & >> ~/polybar.log
else
	# start bars on each monitor
	echo "Starting multiple bars..." >> ~/polybar.log
	for i in $(polybar -m | awk -F: '{print $1}'); do MONITOR=$i polybar example -c ~/.config/polybar/config >> ~/polybar.log & done
fi
# feh --bg-scale ~/.config/wall.png

echo "Bars launched..." >> ~/polybar.log
