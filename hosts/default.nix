{ withSystem, user, sharedModules, inputs, ... }:

{
  flake.nixosConfigurations = withSystem "x86_64-linux" ({ system, self', inputs', ... }: {
    laptop = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = sharedModules ++ [
        ./laptop
        ../modules/boot.nix
        ../modules/impermanence.nix
        ../modules/desktop.nix
        ../secrets/secrets.nix
      ] ++ [{
        home-manager = {
          users.${user}.imports = [
            ../home
            ../home/hyprland
          ];
        };
      }];
    };
  });
}
