{
  pkgs,
  lib,
  config,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    initrd.systemd.enable = true;

    consoleLogLevel = 3; # "loglevel=3"
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "fbcon=nodefer"
    ];

    loader = {
      systemd-boot = lib.mkIf (config.networking.hostName == "server") {
        enable = true;
        consoleMode = "auto";
      };
      grub = {
        enable = !config.boot.loader.systemd-boot.enable;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
        enableCryptodisk = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
