{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [ qt6Packages.fcitx5-unikey ];
      waylandFrontend = true;
    };
  };

  # home.file.".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
  home.file.".config/fcitx5/conf/clipboard.conf".source = ./clipboard.conf;
  home.file.".config/fcitx5/profile".source = ./profile;
  home.file.".config/fcitx5/config".source = ./config;
  # home.file.".local/share/fcitx5/themes/Nord/theme.conf".text = import ./theme.nix;
}
