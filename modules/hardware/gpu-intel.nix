{pkgs, ...}: {
  services = {
    tlp.enable = true; # optimized for battery life
    auto-cpufreq.enable = true; # Automatic CPU speed & power optimizer for Linux
    # xserver.videoDrivers = [ "nvidia" ];
  };
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
