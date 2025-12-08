#!/usr/bin/env bash

# Get birth time if supported, otherwise modification time of /
birth=$(stat -c %w / 2>/dev/null 2>/dev/null)
[ "$birth" = "-" ] || [ -z "$birth" ] && birth=$(stat -c %z /)

install_sec=$(date -d "$birth" +%s)
now_sec=$(date +%s)
elapsed_sec=$(( now_sec - install_sec ))

days=$(( elapsed_sec / 86400 ))

# If "sec" argument is given → detailed output
if [[ "$1" == "sec" ]]; then
    remaining=$(( elapsed_sec % 86400 ))
    hours=$(( remaining / 3600 ))
    remaining=$(( remaining % 3600 ))
    mins=$(( remaining / 60 ))
    secs=$(( remaining % 60 ))

    printf "%d days, %d hours, %d minutes, %d seconds\n" $days $hours $mins $secs
else
    # Default: only full days
    echo "$days"
fi
