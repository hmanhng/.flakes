{ pkgs, ... }:
{
  imports = [
    ./obs-studio.nix
    ./vicinae.nix
  ];
  home.packages = with pkgs; [
    meld
    scrcpy
    transmission_4-qt
  ];
}
