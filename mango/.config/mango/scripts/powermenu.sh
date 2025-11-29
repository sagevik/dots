
#!/bin/sh

font="Hack Bold 16"

# Pass variables to dmenu
run_dmenu() {
  printf "Lock\nSuspend\nLogout\nReboot\nShutdown" | sort | wmenu -f "$font" -i -c -w 400 -l 5 $WMENU_COLORS -p "Power Menu"
}

chosen="$(run_dmenu)"
case $chosen in
  "Lock")
      sleep 1
      hyprlock
      ;;
  "Suspend")
      hyprlock &
      sleep 1
      systemctl suspend
      ;;
  "Logout")
      sleep 1
      pkill -KILL -u $USER
      ;;
  "Reboot")
      sleep 1
      systemctl reboot
      ;;
  "Shutdown")
      sleep 1
      systemctl poweroff
      ;;
  *)
      exit 0
      ;;
esac
