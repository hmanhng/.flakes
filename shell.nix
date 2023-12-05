{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  shellHook = ''
    exec fish
    echo "
    Hmanhng dep trai vcl
    "
      export PS1="[\e[0;34m(Flakes)\$\e[m:\w]\$ "
  '';
  buildInputs = with pkgs; [
    # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
    gst_all_1.gstreamer
    # Common plugins like "filesrc" to combine within e.g. gst-launch
    gst_all_1.gst-plugins-base
    # Specialized plugins separated by quality
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    # Plugins to reuse ffmpeg to play almost every video format
    gst_all_1.gst-libav
    # Support the Video Audio (Hardware) Acceleration API
    gst_all_1.gst-vaapi
    #...
  ];
}
