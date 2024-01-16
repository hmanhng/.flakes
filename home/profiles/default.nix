{
  self,
  inputs,
  withSystem,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {
    "hmanhng@laptop" = [
      ../.
      ./laptop
    ];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  # we need to pass this to NixOS' HM module
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "hmanhng@laptop" = homeManagerConfiguration {
        modules = homeImports."hmanhng@laptop";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
