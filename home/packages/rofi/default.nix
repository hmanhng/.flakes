{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      rofi-wayland
    ];
  };
  xdg.configFile."rofi/launcher" = { source = ./launcher; recursive = true; };
  xdg.configFile."rofi/cliphist" = { source = ./cliphist; recursive = true; };
  xdg.configFile."rofi/powermenu" = { source = ./powermenu; recursive = true; };
  xdg.configFile."rofi/colors.rasi".source = ./colors.rasi;
}
