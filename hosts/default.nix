{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    # shorten paths
    inherit (inputs.nixpkgs.lib) nixosSystem;

    howdy = inputs.nixpkgs-howdy;

    homeImports = import "${self}/home/profiles";

    mod = "${self}/system";
    # get the basic config to build on top of
    inherit (import mod) laptop;

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

          "${mod}/hardware/amdgpu.nix" # for amdgpu
          "${mod}/impermanence"
          "${mod}/impermanence/btrfs.nix"

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
