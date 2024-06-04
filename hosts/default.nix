{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    howdy = inputs.nixpkgs-howdy;

    # get the basic config to build on top of
    inherit (import "${self}/system") desktop laptop;

    # get these into the module system
    specialArgs = {inherit inputs self;};
  in {
    laptop = nixosSystem {
      inherit specialArgs;
      modules =
        laptop
        ++ [
          ./laptop
          "${self}/secrets"
          "${self}/modules/android.nix"
          # "${self}/modules/dev.nix"
          # "${self}/modules/virtual"
          # ../modules/devops

          "${self}/system/hardware/amdgpu.nix" # for amdgpu
          "${self}/system/impermanence"
          "${self}/system/impermanence/btrfs.nix"

          {
            home-manager = {
              users.hmanhng.imports = homeImports."hmanhng@laptop";
              extraSpecialArgs = specialArgs;
            };
          }

          {disabledModules = ["security/pam.nix"];}
          "${howdy}/nixos/modules/security/pam.nix"
          "${howdy}/nixos/modules/services/security/howdy"
          "${howdy}/nixos/modules/services/misc/linux-enable-ir-emitter.nix"

          inputs.disko.nixosModules.disko
        ];
    };
  };
}
