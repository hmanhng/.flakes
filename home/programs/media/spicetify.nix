{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  # themable spotify
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    windowManagerPatch = true;

    theme = spicePkgs.themes.text;
    colorScheme = "RosePine";

    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      newReleases
      reddit
      marketplace
    ];
    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      shuffle

      # powerBar
      seekSong
      # playlistIcons
      fullAlbumDate
      fullAppDisplayMod
      showQueueDuration
      history
      betterGenres
      hidePodcasts
      adblock
      playNext
      volumePercentage
    ];
  };
}
