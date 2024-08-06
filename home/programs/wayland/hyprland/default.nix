{
  pkgs,
  inputs,
  ...
}: let
  cursor = "Bibata-Modern-Ice-Hyprcursor";
  cursorPackage = inputs.self.legacyPackages.${pkgs.system}.bibata-hyprcursor;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";

  # programs.fish.loginShellInit = ''
  #   set TTY1 (tty)
  #   [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
  # '';
  wayland.windowManager.hyprland = {
    enable = true;

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
