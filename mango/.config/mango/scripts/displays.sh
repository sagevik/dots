#!/bin/sh

option=$(printf "38 dual\n38 only\nIntegrated\nManual" | wmenu -i -l 4 -p "Select Display Setup")

case $option in
    "38 dual")
        wlr-randr --output eDP-1 --on
        wlr-randr --output DP-5 --on
        wlr-randr --output DP-5 --mode 3840x1600 --right-of eDP-1 --output eDP-1 --mode 1920x1200
        ;;
    "38 only")
        wlr-randr --output DP-5 --on
        wlr-randr --output eDP-1 --off
        wlr-randr --output DP-5 --mode 3840x1600
        ;;
    "Integrated")
        wlr-randr --output eDP-1 --on
        wlr-randr --output eDP-1 --mode 1920x1200
        ;;
    "Manual")
        wdisplays
        ;;
    *)
        exit
        ;;
esac
