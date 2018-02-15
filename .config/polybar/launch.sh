#!/bin/sh

# terminate existing instances
killall -q polybar

# wait until the processes are dead
while pgrep -x polybar >/dev/null; do
	sleep 1
done

# launch the bar
polybar top
