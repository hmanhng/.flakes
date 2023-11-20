{
  pkgs,
  default,
  ...
}: {
  imports = [
    ./code
    ./nvim
    ./emacs
    ./jetbrains
  ];
  home = {
    sessionVariables = {
      EDITOR = "${default.editor}";
    };
  };
  home.packages = with pkgs; [
    shfmt
    nodePackages.bash-language-server

    nil
    alejandra

    # texlive.combined.scheme-medium
    # required by +jupyter
    # (python3.withPackages (ps: with ps; [jupyter]))
  ];
}
