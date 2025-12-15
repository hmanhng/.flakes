{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./fonts.nix
    ./gui.nix
    ./home-manager.nix
    ./xdg.nix
  ];

  programs.dconf.enable = true; # make HM-managed GTK stuff work

  environment.systemPackages = [
    inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.nix-alien
  ];
  # Optional, needed for `nix-alien-ld`
  programs.nix-ld.enable = true;
}
