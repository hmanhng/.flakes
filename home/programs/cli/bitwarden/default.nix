{
  inputs,
  pkgs,
  config,
  self,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden-cli
    inputs.bitwarden-menu.packages.${pkgs.system}.default
    flyctl
    go-task
  ];
  sops.secrets.bitwarden = {
    sopsFile = "${self}/secrets/bitwarden.yaml";
    path = "${config.xdg.configHome}/bwm/config.ini";
  };
  home.activation.setupEtc = config.lib.dag.entryAfter ["writeBoundary"] ''
    /run/current-system/sw/bin/systemctl start --user sops-nix
  '';
}
