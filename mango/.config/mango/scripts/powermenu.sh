
#!/bin/sh

font="Hack Bold 28"

# Pass variables to dmenu
run_dmenu() {
  printf "󰌾 Lock\n󱋒 Suspend\n Logout\n Reboot\n󰐥 Shutdown" | sort | wmenu -f "$font" -i -c -w 300 -l 5 $WMENU_COLORS -p "?"
}

chosen="$(run_dmenu)"
case $chosen in
  "󰌾 Lock")
      sleep 1
      hyprlock
      ;;
  "󱋒 Suspend")
      hyprlock &
      sleep 1
      systemctl suspend
      ;;
  " Logout")
      sleep 1
      pkill -KILL -u $USER
      ;;
  " Reboot")
      sleep 1
      systemctl reboot
      ;;
  "󰐥 Shutdown")
      sleep 1
      systemctl poweroff
      ;;
  *)
      exit 0
      ;;
esac
