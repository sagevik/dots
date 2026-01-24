#!/usr/bin/env bash

font="Hack Bold 24"

get_profile() {
    profile=$(powerprofilesctl get)
    case "$profile" in
        "balanced")
            icon=" "
            text="Balanced"
            ;;
        "performance")
            icon="󱐋"
            text="Performance"
            ;;
        "power-saver")
            icon="󰑌 "
            text="Power Saver"
            ;;
        *)
            icon="❓ "
            text="Unknown"
            ;;
    esac
    # Output just the icon by default. 
    # For icon + text: echo "{\"text\": \"$icon $text\", \"tooltip\": \"Power Profile: $text\", \"class\": \"$profile\"}"
    # For just text: echo "{\"text\": \"$text\", \"tooltip\": \"Power Profile: $text\", \"class\": \"$profile\"}"
    echo "{\"text\": \"$icon\", \"tooltip\": \"Power Profile: $text\", \"class\": \"$profile\"}"
}

declare -A profiles=(
  [" Balanced"]="balanced"
  ["󱐋 Performance"]="performance"
  ["󰑌 Power saver"]="power-saver"
)

get_current_profile_key() {
  local current_value
  current_value=$(powerprofilesctl get)
  for key in "${!profiles[@]}"; do
    if [ "${profiles[$key]}" = "$current_value" ]; then
      echo "$key"
      return
    fi
  done
  echo "Unknown"
}

build_menu() {
  local current
  current=$(powerprofilesctl get)

  for key in "${!profiles[@]}"; do
    if [ "${profiles[$key]}" = "$current" ]; then
      printf '* %s\n' "$key"
    else
      printf '%s\n' "$key"
    fi
  done
}

run_dmenu() {
  local current_profile
  current_profile=$(get_current_profile_key)
  build_menu | sort | wmenu -f "$font" -c -i -l "${#profiles[@]}" $WMENU_COLORS -p "Profile"
}


if [ "$1" = "set" ]; then

  chosen=$(run_dmenu)
  [ -z "$chosen" ] && exit 0

  if [[ -n "${profiles[$chosen]}" ]]; then
      powerprofilesctl set "${profiles[$chosen]}"
      notify "${profiles[$chosen]}"
      pkill -RTMIN+8 waybar
  fi

  exit 0
fi

get_profile

