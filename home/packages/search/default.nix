{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      fd
      ripgrep
    ];
  };
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
      "--height 80%"
      "--layout reverse"
      "--info inline"
      "--border --color 'border:#b48ead'"
    ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];
  };
  programs.bat = {
    enable = true;
    themes = {
      Catppuccin-macchiato = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-macchiato.tmTheme";
      };
    };
    config = {
      theme = "Catppuccin-macchiato";
    };
  };
}
