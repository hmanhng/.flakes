{pkgs, ...}: {
  imports = [
    ./bash
    ./fish
    ./git.nix
    ./top.nix
    ./starship.nix
    #./zsh/zsh
  ];
  # add environment variables
  home.sessionVariables = {
    # auto-run programs using nix-index-database
    NIX_AUTO_RUN = "1";
  };

  programs.nix-index-database.comma.enable = true;

  home.packages = with pkgs; [
    fd
    ripgrep
    jaq

    ## Tool, etc ...
    cargo
    cmake
    dotnet-sdk_7
    gcc
    gnumake
    lua

    #
    nitch
    speedtest-go
    killall
    socat
    unrar
    unzip
    wget
    zip
  ];
  programs.thefuck.enable = true;
  programs.direnv.enable = true;
  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
    defaultCommand = "fd --type f --hidden";
    defaultOptions = [
      "--preview 'bat --line-range :500 {}'"
      "--preview-window=right,60%,border-left"
      "--border=sharp --color 'border:#00B4FF'"
      "--height=95%"
      "--layout=reverse-list"
      "--inline-info"
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
      style = "numbers,changes";
      color = "always";
      italic-text = "always";
      pager = "less -FR";
      map-syntax = [
        "*.h:cpp"
        ".ignore:.gitignore"
      ];
    };
  };
}
