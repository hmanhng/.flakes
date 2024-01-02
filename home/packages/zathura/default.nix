{
  pkgs,
  inputs,
  ...
}: {
  programs.zathura = {
    enable = true;
    package = inputs.nixpkgs-zathura.legacyPackages.${pkgs.system}.zathura;
    extraConfig = ''
      include ${./catppuccin-macchiato}
      set font "JetBrainsMono Nerd Font 16"

      # Zathura configuration file
      # See man `man zathurarc'

      # Open document in fit-width mode by default
      set adjust-open "best-fit"

      # One page per row by default
      set pages-per-row 1

      #stop at page boundries
      set scroll-page-aware "true"
      set scroll-full-overlap 0.01
      set scroll-step 100

      #zoom settings
      set zoom-min 10
      # set guioptions ""

      # zathurarc-dark

      set render-loading "false"
      set scroll-step 50

      set selection-clipboard clipboard
    '';
  };
}
