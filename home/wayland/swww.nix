{
  config,
  lib,
  pkgs,
  default,
  ...
}: {
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
          ExecStartPost = "${lib.getExe pkgs.swww} img ${default.wallpaper}";
          ExecStop = "${lib.getExe pkgs.swww} kill";
          Restart = "on-failure";
        };
      };
    };
  };
}
