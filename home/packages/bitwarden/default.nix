{
  inputs,
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden-cli
    inputs.bitwarden-menu.packages.${pkgs.system}.default
    flyctl
    go-task
  ];
  sops.secrets.bitwarden = {
    sopsFile = ../../../secrets/bitwarden.yaml;
    path = "${config.xdg.configHome}/bwm/config.ini";
  };
}
