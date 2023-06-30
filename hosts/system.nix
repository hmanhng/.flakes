{ config, pkgs, lib, inputs, user, ... }:

{
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
    hosts = {
      "185.199.109.133" = [ "raw.githubusercontent.com" ];
      "185.199.111.133" = [ "raw.githubusercontent.com" ];
      "185.199.110.133" = [ "raw.githubusercontent.com" ];
      "185.199.108.133" = [ "raw.githubusercontent.com" ];
    };
  };
  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  environment = { binsh = "${pkgs.dash}/bin/dash"; };

  boot = {
    supportedFilesystems = [ "ntfs" ];
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
      # "nvidia-drm.modeset=1"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  nix = {
    settings = {
      warn-dirty = false;
      accept-flake-config = true;
      trusted-users = [ "root" "${user}" ];
      builders-use-substitutes = true;
      auto-optimise-store = true; # Optimise syslinks
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "22.11";
}
