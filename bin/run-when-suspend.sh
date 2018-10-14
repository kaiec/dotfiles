#!/bin/bash
DISPLAY=:1
/home/kai/.screenlayout/nb
/bin/sleep 1
/home/kai/dotfiles/bin/lock
# Add dotfiles/suspend/lock@.service to /etc/systemctl/system
# Enable with systemctl enable lock@kai.service
