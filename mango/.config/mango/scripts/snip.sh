choice=$1

time=$(date +%Y-%m-%d_%H-%M-%S)
file="/home/rs/pix/screenshots/screenshot_$time.png"
case $choice in
  "selection")
    grim -l 0 -g "$(slurp)" $file
    notify-send "Screenshot" "$choice saved to $file"
    ;;
  "screen")
    grim -l 0 $file
    notify-send "Screenshot" "$choice saved to $file"
    ;;
  "clipboard")
    grim -l 0 -g "$(slurp)" - | wl-copy
    notify-send "Screenshot" "put to $choice"
    ;;

esac
