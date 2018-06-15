#!/bin/bash

# Try to identify the CWD of the currently
# open and selected window and open a new
# terminal in the same window.

# https://faq.i3wm.org/question/150/how-to-launch-a-terminal-from-here/%3C/p%3E.html

ID=$(xdpyinfo | grep focus | cut -f4 -d " ")
PID=$(($(xprop -id $ID | grep -m 1 PID | cut -d " " -f 3) + 2))
if [ -e "/proc/$PID/cwd" ]
then
    urxvt -cd "$(readlink /proc/$PID/cwd)" &
else
    urxvt
fi
