{pkgs, ...}: let
  mpv-file-browser = pkgs.fetchFromGitHub {
    owner = "CogentRedTester";
    repo = "mpv-file-browser";
    rev = "147a615a9597874e3c54a16b06931df9343b0190";
    sha256 = "sha256-5RA34y98I7qR806CROb3G4IcyXTb5tXMXmUI0oqN20M=";
  };
in {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      mpv-cheatsheet
      # mpv-notify-send # error now
      autosubsync-mpv
      webtorrent-mpv-hook
    ];
  };
  xdg.configFile."mpv/mpv.conf".source = ./mpv.conf;
  xdg.configFile."mpv/scripts" = {
    source = ./scripts;
    recursive = true;
  };
  xdg.configFile."mpv/scripts/file-browser" = {
    source = "${mpv-file-browser}";
    recursive = true;
  };
}
