{ config, pkgs, ... }:
{
  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_latte";
      };
    };
    htop = {
      enable = true;
    };
  };
  home.file.".config/btop/themes/catppuccin_latte.theme".source = ./btop_theme.nix;
}
