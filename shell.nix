{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  shellHook = ''
    echo "
    Hmanhng dep trai vcl
    "
    exec fish
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
