{
  config,
  lib,
  pkgs,
  ...
}: let
  wallpaper = builtins.fetchurl {
    url = "https://i.imgur.com/6zpmPd8.png";
    sha256 = "sha256-X3I/rNGko+vAadD9jxqp/xbvML/KbuSMfOy/YHI+Ro0=";
  };
in {
  config = lib.mkIf (config.wayland.windowManager.hyprland.enable) {
    systemd.user.services = {
      swww = {
        Unit = {
          Description = "Efficient animated wallpaper daemon for wayland";
          PartOf = ["graphical-session.target"];
        };
        Install.WantedBy = ["graphical-session.target"];
        Service = {
          Type = "simple";
          ExecStart = "${pkgs.swww}/bin/swww-daemon";
          ExecStartPost = "${lib.getExe pkgs.swww} img ${wallpaper}";
          ExecStop = "${lib.getExe pkgs.swww} kill";
          Restart = "on-failure";
        };
      };
    };
  };
}
