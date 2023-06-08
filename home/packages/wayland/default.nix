let
  common = import ../common;
in
[
  ./fcitx5
  ./notice
  ./rofi
  ./swww
  ./waybar/hyprland_waybar.nix
] ++ common
