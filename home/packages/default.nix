{ config, pkgs, inputs, ... }:
{
  imports = (import ./wayland);
  home.packages = with pkgs; [
    ## Requirement for hyprland
    alsa-lib
    imagemagick # for grimblast
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    killall
    pamixer
    socat
    swaylock-effects
    wl-clipboard
    wlr-randr
    wf-recorder
    xdg-utils

    ## Programs
    cinnamon.nemo
    gnome.file-roller
    imv
    meld
    pavucontrol
    stremio
    vlc

    ## Tool, etc ...
    cargo
    cmake
    gcc
    go
    gnumake
    lua
    nodejs

    ##
    # alsa-utils
    flac
    # pulsemixer
    unzip
    wget
    zip
  ];
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
    homedir = "${config.xdg.dataHome}/gnupg";
  };
  programs = {
    yt-dlp = {
      enable = true;
    };
  };
  home.file.".config/yt-dlp/config".text = ''
    --ignore-errors
    -o %(title)s.%(ext)s
    # Prefer 1080p or lower resolutions
    -f bestvideo[ext=mp4][width<2000][height<=1200]+bestaudio[ext=m4a]/bestvideo[ext=webm][width<2000][height<=1200]+bestaudio[ext=webm]/bestvideo[width<2000][height<=1200]+bestaudio/best[width<2000][height<=1200]/best
    --add-metadata
    --embed-thumbnail
  '';
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
  services.network-manager-applet.enable = true;
  services.udiskie.enable = true;
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };
}
