{
  self,
  inputs,
  default,
  ...
}: let
  module_args._module.args = {
    inherit inputs self default;
  };
in {
  imports = [
    {
      _module.args = {
        inherit module_args;

        sharedModules = [
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
            };
          }
          {
            nixpkgs = {
              overlays =
                (import ../overlays)
                ++ [
                  inputs.neovim-nightly-overlay.overlay
                  inputs.nur.overlay
                ];
            };
          }
          inputs.nur.nixosModules.nur
          inputs.home-manager.nixosModules.home-manager
          inputs.nh.nixosModules.default
          inputs.disko.nixosModules.disko
          module_args

          self.nixosModules.core
          self.nixosModules.network
        ];
      };
    }
  ];
  flake.nixosModules = {
    core = import ./core;
    network = import ./network;
  };
}
