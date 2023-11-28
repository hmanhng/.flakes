{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-ld.nixosModules.nix-ld];
  programs.nix-ld.dev.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.nix-alien.packages.${pkgs.system}.nix-alien
  ];
}
