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
    # nixfmt
    alejandra

    # Java
    jdt-language-server
    google-java-format

    # Go
    gopls

    # Latex
    tectonic
    (texliveBasic.withPackages (
      ps: with ps; [
        dvisvgm
        dvipng
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        # biblatex
        # biber
        # synctex
        # fancyhdr
        # latexmk
        # babel-vietnamese # Support vietnamese // lualatex support default.
      ]
    ))
  ];
}
