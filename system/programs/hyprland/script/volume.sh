#!/usr/bin/env bash

get_volume() {
  volume=$(pamixer --get-volume)
  volume_mic=$(pamixer --get-volume --default-source)

  muted=$(pamixer --get-mute)
  muted_mic=$(pamixer --get-mute --default-source)
  icon="/home/hmanhng/.local/share/icons/svg/"
  icon_mute="/home/hmanhng/.local/share/icons/svg/volume-x.svg"

  if [ "$volume" -lt 30 ]; then
    icon+="volume.svg"
  elif [ "$volume" -ge 30 ] && [ "$volume" -le 70 ]; then
    icon+="volume-1.svg"
  else
    icon+="volume-2.svg"
  fi
}

down() {
  pamixer -d 2
  get_volume
  notify-send -a "VOLUME" "Decreasing to $volume%" -h int:value:"$volume" -i $icon -h string:x-canonical-private-synchronous:sys-notify -u low -c bottom-center
}

up() {
  pamixer -i 2
  get_volume
  notify-send -a "VOLUME" "Increasing to $volume%" -h int:value:"$volume" -i $icon -h string:x-canonical-private-synchronous:sys-notify -u low -c bottom-center
}

mute() {
  get_volume
  if $muted; then
    pamixer -u
    notify-send -a "VOLUME" "UNMUTE $volume%" -h int:value:"$volume" -i $icon -h string:x-canonical-private-synchronous:sys-notify -u low -c bottom-center
  else
    pamixer -m
    notify-send -a "VOLUME" "MUTED" -i $icon_mute -h string:x-canonical-private-synchronous:sys-notify -u low -c bottom-center
  fi
}

mute_mic() {
  get_volume
  if $muted_mic; then
    pamixer --default-source -u
    notify-send -a "VOLUME" "UNMUTE $volume_mic%" -h int:value:"$volume_mic" -i /home/hmanhng/.local/share/icons/svg/microphone-on.svg -h string:x-canonical-private-synchronous:sys-notify -u low -c bottom-center
  else
    pamixer --default-source -m
    notify-send -a "VOLUME" "MUTED" -i /home/hmanhng/.local/share/icons/svg/microphone-off.svg -h string:x-canonical-private-synchronous:sys-notify -u low -c bottom-center
  fi
}

case "$1" in
up) up ;;
down) down ;;
mute) mute ;;
mute_mic) mute_mic ;;
esac
