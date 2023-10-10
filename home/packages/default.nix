{ config, pkgs, inputs', self', ... }:
{
  imports = (import ./wayland);
  home.packages = (with pkgs; [
    ## Programs
    cinnamon.nemo-with-extensions
    gnome.file-roller
    imv
    libreoffice-qt
    meld
    motrix
    pavucontrol
    qbittorrent
    stremio
    vlc

    ## Tool, etc ...
    cargo
    cmake
    dotnet-sdk_7
    gcc
    go
    gnumake
    lua
    nodejs

    ##
    # alsa-utils
    flac
    # pulsemixer
    unrar
    unzip
    wget
    wireguard-tools
    zip
  ]) ++ (with self'.legacyPackages; [
    spoof-dpi
  ]);
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
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
