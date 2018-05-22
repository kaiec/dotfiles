#!/bin/bash
if [ -f ~/.pomo.txt.tmux ] && [ "$(($(date +%s) - $(date +%s -r ~/.pomo.txt.tmux)))" -lt 60 ]
then
	echo -n $(cat ~/Documents/pomodoro_log.txt | tail -n1 | sed 's/.* \(started\|completed\):[ ]\+[0-9]*-[0-9]*-[0-9]*//' | xargs)
	echo " | $(cat ~/.pomo.txt.tmux)"
else
	echo ""
fi
