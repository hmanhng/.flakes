{
  self,
  pkgs,
  lib,
  ...
}: let
  spoofdpi = pkgs.writeShellScriptBin "launch_spoofdpi" ''
    killall spoofdpi
    ${lib.getExe self.legacyPackages.${pkgs.system}.spoofdpi} &
  '';
in {
  home.packages = [spoofdpi];

  imports = [
    # ./firefox
    ./qutebrowser
    ./thorium-browser
    ./zen.nix
  ];
}
