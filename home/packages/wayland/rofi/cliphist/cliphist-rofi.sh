#!/usr/bin/env bash

cliphist_dir="~/.config/rofi/cliphist"
rofi -modi clipboard:$cliphist_dir/cliphist-rofi -show clipboard -theme $cliphist_dir/cliphist-rofi.rasi
