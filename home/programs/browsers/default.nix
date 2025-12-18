{
  self,
  pkgs,
  lib,
  ...
}:
let
  spoofdpi = pkgs.writeShellScriptBin "launch_spoofdpi" ''
    killall spoofdpi
    ${lib.getExe self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.spoofdpi} &
  '';
in
{
  home.packages = [ spoofdpi ];

  imports = [
    # ./firefox
    ./qutebrowser
    ./ungoogled-chromium.nix
    ./zen.nix
  ];
}
