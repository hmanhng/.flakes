#/usr/bin/env bash

bookmarks=~/.flakes/home/bookmarks/default
rofi="rofi -dmenu -theme ~/.config/rofi/cliphist/cliphist-rofi.rasi -p Bookmarks"

ydotool type -d 1 "$(grep -v "^#" $bookmarks | $rofi)"
