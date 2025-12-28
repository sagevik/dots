#!/usr/bin/env bash
font="Hack Bold 26"

selection=$(echo -e "Gimp\nQalculate\nAudacity\nArdour\nPure Data" | sort | wmenu -f "$font" -c -i -l 5 -p "?")

case $selection in
  "Gimp")
    gimp
    ;;
  "Qalculate")
    qalculate-gtk
    ;;
  "Audacity")
    ~/.local/share/appimage/audacity-linux-3.7.6-x64-22.04.AppImage
    ;;
  "Ardour")
   ardour8
    ;;
  "Pure Data")
    pd
    ;;
  *)
    exit 0
    ;;
esac

