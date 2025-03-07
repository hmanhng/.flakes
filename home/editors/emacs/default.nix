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
      then pkgs.emacs30-pgtk
      else pkgs.emacs30;
    overrides = self: super: {};
    extraPackages = epkgs: [
      epkgs.vterm
      # epkgs.editorconfig
      # epkgs.emms
      # epkgs.magit
    ];
    extraConfig = ''
    '';
  };
  home = {
    sessionVariables = {
      # Minemacs
      # MINEMACS_ALPHA = "90";
    };
    sessionPath = ["$HOME/.config/emacs/bin"];
  };
  # systemd.user.services.emacs.Service = {
  #   Environment = [
  #     "MINEMACS_DIR=${config.home.homeDirectory}/.config/minemacs"
  #     "MINEMACS_ALPHA=90"
  #   ];
  # };
  services.emacs = {
    enable = false;
    defaultEditor = false;
    client = {
      enable = true;
      arguments = ["-c"];
    };
  };
}
