{
  pkgs,
  lib,
  config,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
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
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 3;
    };
  };
}
