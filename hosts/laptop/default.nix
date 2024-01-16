{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "laptop"; # Define your hostname.

  # security.tpm2.enable = true;

  services = {
    # for SSD/NVME
    fstrim.enable = true;

    # howdy = {
    #   enable = true;
    #   package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.howdy;
    #   settings = {
    #     core.no_confirmation = true;
    #     video.device_path = "/dev/video0";
    #     debug.end_report = true;
    #   };
    # };
  };

  # Accelerated Video Playback
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware.opengl = {
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    ];
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  boot = {
    kernelParams = [
      "i915.enable_guc=2"
      "ideapad_laptop.allow_v4_dytc=Y"
      ''acpi_osi="Windows 2020"''
      # "nvidia-drm.modeset=1"
    ];

    # Make some extra kernel modules available to NixOS
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];

    # Activate kernel modules (choose from built-ins and extra ones)
    kernelModules = [
      "ideapad_laptop"
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
  };
}
