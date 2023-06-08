#!/usr/bin/env bash

cat ~/.config/hypr/hyprland.conf |
	rg bind |
	rg = |
	sed -e "s/ , / /g" -e "s/\$mainMod/SUPER/g" -e "s/= /=/g" |
	cut -d "=" -f 2- |
	rofi -dmenu -i -p Keybind -theme ~/.config/rofi/launchers/keybind.rasi
