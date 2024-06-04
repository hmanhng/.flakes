{
  lib,
  self,
  inputs,
  ...
}: {
  imports = [
    ./specialisations.nix
    ./cli
    inputs.matugen.nixosModules.default
    inputs.nix-index-db.hmModules.nix-index
    inputs.sops-nix.homeManagerModules.sops
    self.nixosModules.theme
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

  programs = {
    # let HM manage itself when in standalone mode
    home-manager.enable = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      lib = prev.lib // {colors = import "${self}/lib/colors" lib;};
    })
  ];
}
