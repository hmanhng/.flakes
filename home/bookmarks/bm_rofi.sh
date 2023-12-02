#/usr/bin/env bash

trap 'rm /tmp/.bookmarks' EXIT
rofi -modes bookmarks:~/.flakes/home/bookmarks/bm -show bookmarks

if [ -f /tmp/.bookmarks ]; then
    ydotool key 29:1 47:1 47:0 29:0
fi
