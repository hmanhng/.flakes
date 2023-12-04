{
  config,
  pkgs,
  self,
  ...
}: let
  excludedDirectories = ["logseq" "music"];
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
      imv
      # libreoffice-qt
      meld
      motrix
      pavucontrol
      qbittorrent
      stremio
      vlc
      teams-for-linux
    ])
    ++ (with self.legacyPackages.${pkgs.system}; [
      ]);

  services.udiskie.enable = true;

  systemd.user.services.xdg-user-data-dirs = {
    Unit = {
      Description = "Configure XDG user dirs";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update";
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };
}
