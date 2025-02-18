{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # (import ../../../modules/hyprland.nix inputs)
    inputs.hyprland.nixosModules.default

    ./binds.nix
    ./rules.nix
    ./settings.nix
    # ./smartgaps.nix
  ];

  environment.systemPackages = [
    # inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    inputs.self.legacyPackages.${pkgs.system}.bibata-hyprcursor
  ];

  environment.pathsToLink = ["/share/icons"];

  # enable hyprland and required options
  programs.hyprland = {
    enable = true;

    # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
    # hyprbars
    # hyprexpo
    # ];
  };

  # tell Electron/Chromium to run on Wayland
  environment.variables.NIXOS_OZONE_WL = "1";
}
