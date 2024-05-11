{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  shellHook = ''
    exec fish
    echo "
    Hmanhng dep trai vcl
    "
      export PS1="[\e[0;34m(Flakes)\$\e[m:\w]\$ "
  '';
  buildInputs = with pkgs; [
    pkgs.git
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.frida-python
      python-pkgs.requests
      python-pkgs.colorlog
    ]))
  ];
}
