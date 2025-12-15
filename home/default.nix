{
  lib,
  self,
  inputs,
  ...
}:
{
  imports = [
    ./specialisations.nix
    ./cli
    inputs.nix-index-db.homeModules.nix-index
    inputs.sops-nix.homeManagerModules.sops
    self.modules.theme
  ];

  home = {
    username = "hmanhng";
    homeDirectory = "/home/hmanhng";
    stateVersion = lib.mkDefault "24.05";
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode

  programs.home-manager.enable = true;
}
