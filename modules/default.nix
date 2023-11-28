{
  self,
  inputs,
  user,
  default,
  ...
}: let
  module_args._module.args = {
    inherit inputs self user default;
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

          self.nixosModules.boot
          self.nixosModules.core
          self.nixosModules.nix
          self.nixosModules.network
          self.nixosModules.tailscale
        ];
      };
    }
  ];
  flake.nixosModules = {
    boot = import ./boot.nix;
    core = import ./core.nix;
    nix = import ./nix.nix;
    network = import ./network.nix;
    tailscale = import ./tailscale-autoconnect.nix;
  };
}
