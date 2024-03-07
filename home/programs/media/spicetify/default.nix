{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModule];
  # themable spotify
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
  in {
    enable = true;
    injectCss = true;
    replaceColors = true;
    overwriteAssets = true;
    sidebarConfig = true;

    theme = spicePkgs.themes.text;
    colorScheme = "rosepinemoon";

    enabledCustomApps = with spicePkgs.apps; [lyrics-plus new-releases reddit marketplace];
    enabledExtensions = with spicePkgs.extensions; [
      fullAlbumDate
      shuffle
      seekSong
      playlistIcons
      # genre
      hidePodcasts
      adblock
      keyboardShortcut
    ];
  };
}
