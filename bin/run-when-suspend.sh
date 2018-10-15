#!/bin/bash
DISPLAY=:1
/home/kai/dotfiles/bin/lock
/bin/sleep 2
/home/kai/.screenlayout/nb
# Add dotfiles/suspend/lock@.service to /etc/systemctl/system
# Enable with systemctl enable lock@kai.service
