{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./nvim
  ];
  home.packages = with pkgs; [
    # Latex
    tectonic
  ];
}
