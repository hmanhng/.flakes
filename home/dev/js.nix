{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nodejs-slim_latest
    nodePackages_latest.pnpm
    yarn-berry
    deno
  ];
}
