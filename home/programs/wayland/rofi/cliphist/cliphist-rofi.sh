#!/usr/bin/env bash

cliphist_dir="~/.config/rofi/cliphist"
pkill rofi || uwsm app -- rofi -modi clipboard:$cliphist_dir/cliphist-rofi -show clipboard
