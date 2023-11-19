{
  config,
  pkgs,
  self,
  ...
}: let
  excludedDirectories = ["waybar" "logseq"];
  directoryContents = builtins.readDir ./.;
  directories =
    builtins.filter
    (name: directoryContents."${name}" == "directory" && ! (builtins.elem name excludedDirectories))
    (builtins.attrNames directoryContents);
  imports = map (name: ./. + "/${name}") directories;
in {
  imports = imports;
  home.packages =
    (with pkgs; [
      ## Programs
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.tumbler
      gnome.file-roller
      imv
      # libreoffice-qt
      meld
      motrix
      pavucontrol
      qbittorrent
      stremio
      vlc
      teams-for-linux

      # cli
      wireguard-tools
    ])
    ++ (with self.legacyPackages.${pkgs.system}; [
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
}
