{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./config.nix
    ../../scripts
  ];

  programs.fish.loginShellInit = ''
    set TTY1 (tty)
    [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
  '';
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    enableNvidiaPatches = false;
  };
  systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];

  home = {
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_BIN_HOME = "$HOME/.local/bin";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      NIXOS_OZONE_WL = "1";
      QT_SCALE_FACTOR = "1.25";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";

      GNUHOME = "${config.xdg.dataHome}/gnupg";
      NODE_PATH = "${config.xdg.dataHome}/npm-packages/lib/node_modules";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      GOPATH = "${config.xdg.dataHome}/go";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.local/share/npm-packages/bin"
    ];
  };
}
