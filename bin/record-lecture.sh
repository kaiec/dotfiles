#!/bin/bash

# AUDIO="-f pulse -i alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_6__source -ac 1"

AUDIO=""

TARGET="/home/kai/recording/$(date +%Y-%m-%dT%H-%M)"
mkdir -p $TARGET

# Record all cams
IFS=$'\n'
cam_no=0
cams=$(cams.py)
for cam in $cams; do
	DEV=$(echo "$cam" | cut -f1 -d" ") 
	CODEC=$(echo "$cam" | cut -f2 -d" ")
	SIZE=$(echo "$cam" | cut -f3 -d" ")
	FPS=$(echo "$cam" | cut -f4 -d" ")
	((cam_no=cam_no+1))

	ffmpeg_cmd="ffmpeg $AUDIO -f v4l2 -framerate $FPS -video_size $SIZE -input_format $CODEC -i $DEV -c copy $TARGET/webcam_$cam_no.mkv &"
	echo $ffmpeg_cmd
	eval $ffmpeg_cmd
	echo $! > $TARGET/webcam_$cam_no.pid
done
unset IFS

# Record screen
xoffset=$(xrandr | grep eDP-1 | cut -f4 -d" " | cut -f2 -d+)
yoffset=$(xrandr | grep eDP-1 | cut -f4 -d" " | cut -f3 -d+)
resolution=$(xrandr | grep eDP-1 | cut -f4 -d" " | cut -f1 -d+)
ffmpeg_cmd="ffmpeg -video_size $resolution -framerate 30 -f x11grab -i :0.0+$xoffset,$yoffset $AUDIO $TARGET/screen.mp4 &"
echo $ffmpeg_cmd
eval $ffmpeg_cmd 
echo $! > $TARGET/screen.pid
