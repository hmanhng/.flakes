{
  self,
  pkgs,
  lib,
  ...
}: let
  spoof-dpi = pkgs.writeShellScriptBin "launch_spoof-dpi" ''
    killall spoof-dpi
    ${lib.getExe self.legacyPackages.${pkgs.system}.spoof-dpi} &
  '';
in {
  home.packages = [spoof-dpi];

  imports = [
    ./firefox
    ./qutebrowser
    ./thorium-browser
    ./zen.nix
  ];
}
