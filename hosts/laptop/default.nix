{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "laptop"; # Define your hostname.

  security.tpm2.enable = true;

  services = {
    # for SSD/NVME
    fstrim.enable = true;

    # howdy = {
    #   enable = true;
    #   package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.howdy;
    #   settings = {
    #     core = {
    #       no_confirmation = true;
    #       abort_if_ssh = true;
    #     };
    #     video.dark_threshold = 90;
    #   };
    # };

    # linux-enable-ir-emitter = {
    #   enable = true;
    #   package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.linux-enable-ir-emitter;
    # };
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  boot = {
    kernelParams = [];

    blacklistedKernelModules = [
      "ideapad_laptop" # fix https://bbs.archlinux.org/viewtopic.php?id=295464
    ];

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
  };
}
