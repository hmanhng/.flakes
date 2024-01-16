{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = [
      # pkgs.obs-studio-plugins.obs-gstreamer
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
      # pkgs.obs-studio-plugins.wlrobs
    ];
  };
  home.file.".config/obs-studio/themes".source = ./themes;
}
