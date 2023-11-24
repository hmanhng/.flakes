{pkgs, ...}: {
  boot = {
    initrd = {
      verbose = true;
      supportedFilesystems = ["btrfs"];
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
      # systemd-boot = {
      #   enable = true;
      #   consoleMode = "auto";
      # };
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
        enableCryptodisk = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 3;
    };
    kernelParams = [
      "quiet"
      "splash"
      "fbcon=nodefer"
      # "nvidia-drm.modeset=1"
    ];
    consoleLogLevel = 0;
  };
}
