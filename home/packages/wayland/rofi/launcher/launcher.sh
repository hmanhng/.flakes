#!/usr/bin/env bash

theme="launcher_theme"
dir="$HOME/.config/rofi/launcher"

rofi -show drun -modi drun -theme $dir/"$theme"
