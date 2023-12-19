{
  pkgs,
  default,
  ...
}: let
  jdtls =
    pkgs.runCommand "jdtls" {
      buildInputs = [pkgs.makeWrapper];
    } ''
      mkdir $out
      ln -s ${pkgs.jdt-language-server}/* $out
      rm $out/bin
      mkdir $out/bin
      ln -s ${pkgs.jdt-language-server}/bin/jdt-language-server $out/bin/jdtls
    '';
in {
  imports = [
    ./code
    ./nvim
    ./emacs
    ./eclipse
    # ./jetbrains
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

    jdtls
    # texlive.combined.scheme-medium
    # required by +jupyter
    # (python3.withPackages (ps: with ps; [xdg]))
  ];
}
