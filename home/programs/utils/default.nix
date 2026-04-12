{ pkgs, ... }:
{
  imports = [
    ./obs-studio.nix
    ./vicinae.nix
  ];
  home.packages = with pkgs; [
    meld
    transmission_4-gtk
  ];
}
