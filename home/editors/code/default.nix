{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ];
    /*
       userSettings = {
      "files.autoSave" = "off";
      "[nix]"."editor.tabSize" = 2;
      "window.zoomLevel" = 1.2;
      "editor.fontFamily" = "Liga CodeNewRoman Nerd Font";
      "editor.fontSize" = 19;
    };
    */
  };
  programs.fish.functions = {code = "command code $argv --enable-wayland-ime";};
  xdg.desktopEntries = {
    code = {
      name = "Visual Studio Code";
      icon = "vscode";
      genericName = "Text Editor";
      exec = "code --enable-wayland-ime %U";
      categories = ["Utility" "TextEditor" "Development" "IDE"];
      mimeType = ["text/plain" "inode/directory"];
    };
  };
}
