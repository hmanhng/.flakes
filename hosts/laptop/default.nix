{
  inputs,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "laptop"; # Define your hostname.

  security.tpm2.enable = true;

  services = {
    # for SSD/NVME
    fstrim.enable = true;

    howdy = {
      enable = true;
      package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.howdy;
      settings = {
        core.no_confirmation = true;
        video.device_path = "/dev/video0";
        debug.end_report = true;
      };
    };

    tlp.enable = true; # optimized for battery life
    auto-cpufreq.enable = true; # Automatic CPU speed & power optimizer for Linux
    # xserver.videoDrivers = [ "nvidia" ];
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
    "fbcon=nodefer"
    "i915.enable_guc=2"
    # "nvidia-drm.modeset=1"
  ];
}
