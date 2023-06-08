{ config, lib, pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package =
      if builtins.hasAttr "wayland" pkgs == true then
        pkgs.emacs-pgtk
      else
        pkgs.emacsGit;
    overrides = self: super: { };
    extraPackages = epkgs: [
      # epkgs.emms
      # epkgs.magit
    ];
    extraConfig = ''

    '';
  };
  home.sessionVariables = {
    # Minemacs
    MINEMACS_DIR = "$HOME/.config/minemacs";
    # MINEMACS_ALPHA = "90";
  };
  services.emacs = {
    enable = true;
    defaultEditor = false;
    client = {
      enable = true;
      arguments = [
        "-c"
      ];
    };
    extraOptions = [
      "-f"
      "exwm-enable"
    ];
    socketActivation.enable = true;
    startWithUserSession = true;
  };
}
