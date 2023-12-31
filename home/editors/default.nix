{
  pkgs,
  default,
  ...
}: {
  imports = [
    ./code
    ./nvim
    ./emacs
    # ./eclipse
    # ./jetbrains
  ];
  home = {
    sessionVariables = {
      EDITOR = default.editor;
    };
  };
  home.packages = with pkgs; [
    # shell
    shfmt
    nodePackages.bash-language-server

    # nix
    nil
    alejandra

    # java
    jdt-language-server
    google-java-format

    # go
    gopls

    # texlive.combined.scheme-medium
  ];
}
