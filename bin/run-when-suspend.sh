#!/bin/bash
DISPLAY=:1
/home/kai/.screenlayout/nb.sh
sleep 5 
/usr/bin/i3lock -e -c 000000
# Add dotfiles/suspend/lock@.service to /etc/systemctl/system
# Enable with systemctl enable lock@kai.service
