{
  lib,
  self,
  inputs,
  ...
}: {
  imports = [
    # ./specialisations.nix
    ./cli
    inputs.nix-index-db.hmModules.nix-index
    inputs.sops-nix.homeManagerModules.sops
  ];

  home = {
    username = "hmanhng";
    homeDirectory = "/home/hmanhng";
    stateVersion = lib.mkDefault "23.11";
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs = {
    # let HM manage itself when in standalone mode
    home-manager.enable = true;
  };

  nixpkgs.overlays = [
    # (final: prev: {
    #   lib = prev.lib // {colors = import "${self}/lib/colors" lib;};
    # })
  ];
}
