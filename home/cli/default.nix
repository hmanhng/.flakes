{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./bash
    ./fish
    ./git.nix
    ./nix.nix
    ./top.nix
    ./starship.nix
    ./yazi.nix
    #./zsh/zsh
  ];

  # add environment variables
  home = {
    sessionVariables = {
      # auto-run programs using nix-index-database
      NIX_AUTO_RUN = "1";

      NODE_PATH = "${config.xdg.dataHome}/npm-packages/lib/node_modules";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.local/share/npm-packages/bin"
      "$HOME/.local/share/cargo/bin"
    ];
  };

  programs.nix-index-database.comma.enable = true;

  home.packages = with pkgs; [
    fd
    ripgrep
    jaq

    ## Tool, etc ...
    cargo
    clang-tools
    cmake
    dotnet-sdk
    gcc
    gnumake
    just
    lua

    #
    nitch
    speedtest-go
    killall
    p7zip # Archiving and compression
    socat
    wget
  ];

  # programs.thefuck.enable = true;
  programs.zoxide.enable = true;

  programs.eza.enable = true;

  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
    defaultCommand = "fd --hidden --type l --type f --type d --exclude .git --exclude .cache";
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
    config = {
      style = "full";
      color = "always";
      italic-text = "always";
      pager = "less -FR";
      # map-syntax = [
      #   "*.h:cpp"
      #   ".ignore:.gitignore"
      # ];
    };
  };
}
