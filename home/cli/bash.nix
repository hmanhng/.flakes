{config, ...}: {
  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.stateHome}/history";
      initExtra = ''
      '';
    };
  };
}
