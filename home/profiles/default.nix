{
  self,
  inputs,
  withSystem,
  module_args,
  ...
}: let
  sharedModules = [
    ../.
    ../cli
    module_args
    inputs.nix-index-db.hmModules.nix-index
    inputs.sops-nix.homeManagerModules.sops
  ];

  homeImports = {
    "hmanhng@laptop" = [./laptop] ++ sharedModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  imports = [
    # we need to pass this to NixOS' HM module
    {_module.args = {inherit homeImports;};}
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
      "hmanhng@laptop" = homeManagerConfiguration {
        modules = homeImports."hmanhng@laptop";
        inherit pkgs;
      };
    });

    # homeManagerModules = {
    # };
  };
}
