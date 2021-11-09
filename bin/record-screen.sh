#!/bin/bash

# AUDIO="-f pulse -i alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_6__source -ac 1"

AUDIO=""

TARGET="/home/kai/recording/$(date +%Y-%m-%dT%H-%M)"
mkdir -p $TARGET


# Record screen
xoffset=$(xrandr | grep eDP-1 | cut -f4 -d" " | cut -f2 -d+)
yoffset=$(xrandr | grep eDP-1 | cut -f4 -d" " | cut -f3 -d+)
resolution=$(xrandr | grep eDP-1 | cut -f4 -d" " | cut -f1 -d+)
ffmpeg_cmd="ffmpeg -video_size $resolution -framerate 30 -f x11grab -i :0.0+$xoffset,$yoffset $AUDIO $TARGET/screen.mp4 &"
echo $ffmpeg_cmd
eval $ffmpeg_cmd 
echo $! > $TARGET/screen.pid
