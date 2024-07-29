{pkgs, ...}: {
  imports = [
    ./fcitx5
    ./obs-studio
  ];
  home.packages = with pkgs; [
    meld
    qbittorrent
    scrcpy
  ];
}
