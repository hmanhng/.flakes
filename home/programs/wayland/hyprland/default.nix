{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  # programs.fish.loginShellInit = ''
  #   set TTY1 (tty)
  #   [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
  # '';
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd = {
      variables = ["--all"];
      # extraCommands = [
      # "systemctl --user stop graphical-session.target"
      # "systemctl --user start hyprland-session.target"
      # ];
    };
  };
  # systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
}
