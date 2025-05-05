{pkgs, ...}: {
  imports = [
    ./fcitx5
    ./obs-studio.nix
  ];
  home.packages = with pkgs; [
    meld
    scrcpy
    transmission_4-gtk
  ];
}
