{ self, inputs, user, withSystem, ... }:
let
  module_args = withSystem "x86_64-linux" ({ system, self', inputs', ... }: {
    # system-agnostic args
    _module.args = {
      inherit inputs self inputs' self' user;
    };
  });
in
{
  imports = [{
    _module.args = {
      inherit module_args;

      sharedModules = [
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user}.imports = [
              inputs.hyprland.homeManagerModules.default
              module_args
            ];
          };
        }
        {
          nixpkgs = {
            overlays =
              (import ../overlays)
              ++ [
                inputs.neovim-nightly-overlay.overlay
                inputs.nur.overlay
                (import inputs.emacs-overlay)
              ];
          };
        }
        inputs.impermanence.nixosModules.impermanence
        inputs.sops-nix.nixosModules.sops
        inputs.nur.nixosModules.nur
        inputs.hyprland.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        module_args
        self.nixosModules.boot
        self.nixosModules.core
        self.nixosModules.nix
        self.nixosModules.network
      ];
    };
  }];
  flake.nixosModules = {
    core = import ./core.nix;
    nix = import ./nix.nix;
    network = import ./network.nix;
    boot = import ./boot.nix;
  };
}
