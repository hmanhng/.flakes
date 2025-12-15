{ inputs, ... }:
{
  imports = [ inputs.caelestia-shell.homeManagerModules.default ];
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [ ];
    };
    settings = {
      appearance = {
        # font.size.scale = 0.5;
        anim.durations.scale = 1;
        padding.scale = 0.5;
        rounding.scale = 0.5;
        spacing.scale = 0.5;
        transparency = {
          enabled = true;
          base = 0.8;
          layer = 0.4;
        };
      };
      general = {
        apps.audio = [ "pwvucontrol" ];
      };
      bar = {
        status = {
          showAudio = true;
          showBattery = true;
        };
        tray = {
          compact = true;
        };
        workspaces.label = "";
      };
      osd.enableMicrophone = true;
      services = {
        useFahrenheit = false;
        useTwelveHourClock = false;
      };
      utilities.toasts.nowPlaying = true;
      # paths.wallpaperDir = "~/Images";
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        # theme.enableGtk = true;
      };
    };
  };
}
