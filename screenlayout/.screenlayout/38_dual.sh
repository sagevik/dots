#!/bin/sh
mode=$(optimus-manager --print-mode | awk '{print $3}')

if [ "$mode" = "integrated" ]; then
	# integrated
	# echo "setting display settings for integrated gpu"
	xrandr --output eDP-1 --primary --mode 1920x1200 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-1-1 --off --output DP-1-2 --mode 3840x1600 --pos 1920x0 --rotate normal --output DP-1-3 --off
else
	# nvidia
	# echo "setting display settings for nvida gpu"
	xrandr --output eDP-1-1 --mode 1920x1200 --pos 0x400 --rotate normal --output DP-1-1 --off --output DP-1-2 --off --output DP-1-3 --off --output DP-1-1-1 --off --output DP-1-1-2 --mode 3840x1600 --pos 1920x0 --rotate normal --output DP-1-1-3 --off
fi

