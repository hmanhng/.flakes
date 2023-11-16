{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.emacs = {
    enable = true;
    package =
      if builtins.hasAttr "wayland" pkgs == true
      then pkgs.emacs29-pgtk
      else pkgs.emacs29;
    overrides = self: super: {};
    extraPackages = epkgs: [
      # epkgs.emms
      # epkgs.magit
    ];
    extraConfig = ''

    '';
  };
  home = {
    sessionVariables = {
      # Minemacs
      # MINEMACS_DIR = "$HOME/.config/minemacs";
      # MINEMACS_ALPHA = "90";
    };
    sessionPath = ["$HOME/.config/emacs/bin"];
  };
  services.emacs = {
    enable = true;
    defaultEditor = false;
    client = {
      enable = true;
      arguments = ["-c"];
    };
  };
}
