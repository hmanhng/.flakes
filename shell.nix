{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  shellHook = ''
    echo "
    Hmanhng dep trai vcl
    "
      export PS1="[\e[0;34m(Flakes)\$\e[m:\w]\$ "
  '';
  nativeBuildInputs = with pkgs; [git neovim];
}
