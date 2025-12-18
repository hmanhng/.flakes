{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./nvim
  ];
  home.packages = with pkgs; [
    # Shell
    shfmt
    nodePackages.bash-language-server

    # Nix
    nil

    # Java
    jdt-language-server
    google-java-format

    # Go
    gopls

    # Latex
    tectonic
  ];
}
