#!/usr/bin/env bash

trap 'rm /tmp/.bookmarks' EXIT
pkill rofi || uwsm app -- rofi -modes bookmarks:$(dirname "$0")/bm -show bookmarks

if [ -f /tmp/.bookmarks ]; then
    ydotool key 29:1 47:1 47:0 29:0
fi
