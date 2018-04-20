#!/bin/bash

device="SynPS/2 Synaptics TouchPad"
state=$(xinput list-props "$device" | grep "Device Enabled" | cut -f3)
echo $state

if [ $state == 1 ]; then
xinput --disable "$device"
notify-send -t 1000 "Touch pad disabled"
else
xinput --enable "$device"
notify-send -t 1000 "Touch pad enabled"
fi

