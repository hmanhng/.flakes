{ config, lib, pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-unikey ];
  };

  home.file.".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".config/fcitx5/profile".source = ./profile;
  home.file.".local/share/fcitx5/themes/Nord/theme.conf".text = import ./theme.nix;
}
