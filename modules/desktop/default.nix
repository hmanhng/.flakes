{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./fonts.nix
    # ./greetd.nix
  ];

  # environment.sessionVariables = {
  #  LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib"; # THIS BREAK PACKAGES dynamic binaries on NixOs
  # };

  # (Required) NixOS Module: enables critical components needed to run Hyprland properly
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
    pamixer
  ];

  hardware.brillo.enable = true; # Control light
  programs.dconf.enable = true; # make HM-managed GTK stuff work
  # File explore
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  programs.file-roller.enable = true; # Archive manager

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Pipewire
  hardware.pulseaudio.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  services = {
    # # USE wlsunset
    # clight = {
    #   enable = true;
    #   settings = {
    #     verbose = true;
    #     backlight.disabled = true;
    #     dpms.timeouts = [900 300];
    #     dimmer.timeouts = [870 270];
    #     gamma.long_transition = true;
    #     screen.disabled = true;
    #   };
    # };

    # battery info & stuff
    upower.enable = true;

    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = [pkgs.gcr];

    tumbler.enable = true; # Thumbnail support for images thunar

    gvfs.enable = true; # Needed for udiskie

    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    geoclue2.enable = true; # Location provider
  };
  location.provider = "geoclue2";

  security = {
    # allow wayland lockers to unlock the screen
    pam.services.swaylock.text = "auth include login";
    rtkit.enable = true; # RealtimeKit
    polkit.enable = true; # Controlling system-wide privileges
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
