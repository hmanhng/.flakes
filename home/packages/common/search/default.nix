{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      fd
      ripgrep
    ];
  };
  programs.fzf.enable = true;
  programs.bat = {
    enable = true;
    themes = {
      Catppuccin-macchiato = builtins.readFile (builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-macchiato.tmTheme";
        sha256 = "sha256:0ydk3ysvxgdy829jfl2bwhzhwv3kh5d4k2l6047bi8dwbbid59zg";
      });
    };
    config = {
      theme = "Catppuccin-macchiato";
    };
  };
}
