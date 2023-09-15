{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ];
    /* userSettings = {
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
      "window.zoomLevel" = 1.2;
      "editor.fontFamily" = "Liga CodeNewRoman Nerd Font";
      "editor.fontSize" = 19;
    }; */
  };
}
