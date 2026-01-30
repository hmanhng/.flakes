{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations =
    let
      # shorten paths
      inherit (inputs.nixpkgs.lib) nixosSystem;

      homeImports = import "${self}/home/profiles";

      mod = "${self}/system";
      # get the basic config to build on top of
      inherit (import mod) laptop;

      # get these into the module system
      specialArgs = { inherit inputs self; };
    in
    {
      laptop = nixosSystem {
        inherit specialArgs;
        modules = laptop ++ [
          ./laptop
          "${self}/secrets"

          "${mod}/hardware/amdgpu.nix" # for amdgpu
          "${mod}/core/lanzaboote.nix"
          "${mod}/impermanence"
          "${mod}/impermanence/btrfs.nix"

          "${mod}/programs/hyprland"

          "${mod}/virtualisation/docker.nix"

          {
            home-manager = {
              users.hmanhng.imports = homeImports."hmanhng@laptop";
              extraSpecialArgs = specialArgs;
            };
          }

          inputs.disko.nixosModules.disko
        ];
      };
    };
}
