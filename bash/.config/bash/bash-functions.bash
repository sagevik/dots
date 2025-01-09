
edit_and_reload_sxhkdrc(){
    vim $HOME/.config/sxhkd/sxhkdrc

    killall sxhkd
    notify-send "sxhkd" "sxhkdrc updated. Reload sxhkdrc"
}
