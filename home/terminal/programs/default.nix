{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./git.nix
    ./nix.nix
    ./top.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    fd
    jaq
    ripgrep

    ## Tool, etc ...
    nitch
    speedtest-go
    killall
    ouch # Archiving and compression
    wget
  ];

  # programs.thefuck.enable = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
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
