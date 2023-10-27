{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      logseq
    ];
  };
  programs.fish.shellAliases = { logseq = "logseq --enable-wayland-ime"; };
  xdg.desktopEntries = {
    logseq = {
      name = "Logseq";
      icon = "logseq";
      exec = "logseq --enable-wayland-ime %U";
      terminal = false;
      categories = [ "Utility" ];
      mimeType = [ "x-scheme-handler/logseq" ];
    };
  };
}
