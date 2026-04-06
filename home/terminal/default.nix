{ config, ... }:
{
  imports = [
    ./programs
    ./shell/fish
  ];

  # add environment variables
  home = {
    sessionVariables = {
      # auto-run programs using nix-index-database
      NIX_AUTO_RUN = "1";
    };
  };

  programs.nix-index-database.comma.enable = true;
}
