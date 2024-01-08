{lib, ...}: {
  home = {
    username = "hmanhng";
    homeDirectory = "/home/hmanhng";
  };
  programs = {
    home-manager.enable = true;
  };

  home.stateVersion = lib.mkDefault "23.11";
}
