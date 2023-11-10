{ config, pkgs, inputs', self', ... }:
let
  directoryContents = builtins.readDir ./.;
  directories = builtins.filter
    (name: directoryContents."${name}" == "directory" && name != "waybar")
    (builtins.attrNames directoryContents);
  imports = map (name: ./. + "/${name}") directories;
in
{
  imports = imports;
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
    teams-for-linux

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
  services.udiskie.enable = true;
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };
}
