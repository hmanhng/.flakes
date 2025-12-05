{
  lib,
  pkgs,
  inputs,
  ...
}: let
  cursor = "Bibata-Modern-Ice-Hyprcursor";
  cursorPackage = inputs.self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.bibata-hyprcursor;
in {
  imports = [
    ./binds.nix
    ./rules.nix
    ./settings.nix
  ];

  xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";

  # programs.fish.loginShellInit = ''
  #   set TTY1 (tty)
  #   [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
  # '';
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;

    systemd = {
      enable = false;
      variables = ["--all"];
      # extraCommands = [
      # "systemctl --user stop graphical-session.target"
      # "systemctl --user start hyprland-session.target"
      # ];
    };
  };
  # systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
}
