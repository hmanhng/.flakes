{
  pkgs,
  lib,
  config,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # Make some extra kernel modules available to NixOS
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];

    # Activate kernel modules (choose from built-ins and extra ones)
    kernelModules = [
      # Virtual Camera
      "v4l2loopback"
      # Virtual Microphone, built-in
      "snd-aloop"
    ];

    # Set initial kernel module settings
    extraModprobeConfig = ''
      # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
      # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
      # https://github.com/umlaeute/v4l2loopback
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';

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
