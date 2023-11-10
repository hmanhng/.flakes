{
  config,
  pkgs,
  ...
}: {
  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.stateHome}/history";
      initExtra = ''
      '';
    };
  };
}
