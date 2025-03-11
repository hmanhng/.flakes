{pkgs, ...}: {
  imports = [
    ./fcitx5
    ./obs-studio
  ];
  home.packages = with pkgs; [
    meld
    scrcpy
    transmission_4-gtk
  ];
}
