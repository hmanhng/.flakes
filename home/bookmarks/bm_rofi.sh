#/usr/bin/env bash

bookmarks=~/.flakes/home/bookmarks/default
rofi="rofi -dmenu -theme ~/.config/rofi/cliphist/cliphist-rofi.rasi -p Bookmarks"

ydotool type "$(grep -v "^#" $bookmarks | $rofi)"
