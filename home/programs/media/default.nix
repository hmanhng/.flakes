{pkgs, ...}: {
  imports = [
    ./mpv
    ./spicetify
    ./yt-dlp
    # ./music
  ];
  home.packages = with pkgs; [
    # view image
    imv

    # media
    pamixer
    pavucontrol
    stremio
    vlc
  ];
}
