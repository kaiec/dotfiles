#!/bin/bash
while true
do
	echo `date`
	echo "Fetching new mail"
	mail
	echo "Done fetching mail"
	sleep 10s	
	echo `date`
	echo "Syncing calendars"
	vdirsyncer sync
	echo "Done syncing calendars"
	echo "Go to sleep"
	sleep 5m
done
