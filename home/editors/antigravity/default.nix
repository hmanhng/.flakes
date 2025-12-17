{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.antigravity-nix.packages.x86_64-linux.default
  ];
}
