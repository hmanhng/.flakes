{
  imports = [
    ./fonts.nix
    ./gui.nix
    ./home-manager.nix
    ./hyprland.nix
    ./xdg.nix
  ];

  programs.dconf.enable = true; # make HM-managed GTK stuff work
}
