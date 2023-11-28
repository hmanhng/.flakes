{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [./fonts.nix];

  # environment.sessionVariables = {
  #  LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib"; # THIS BREAK PACKAGES dynamic binaries on NixOs
  # };

  environment.systemPackages = with pkgs; [
    qt6.qtwayland
  ];

  hardware.brillo.enable = true;
  programs.dconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  location.provider = "geoclue2";

  hardware.pulseaudio.enable = lib.mkForce false;

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

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
    };
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = [pkgs.gcr];

    tumbler.enable = true; # Thumbnail support for images

    gvfs.enable = true; # Needed for udiskie

    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    geoclue2.enable = true;
  };

  security = {
    # allow wayland lockers to unlock the screen
    pam.services.swaylock.text = "auth include login";
    rtkit.enable = true; # RealtimeKit
    polkit.enable = true; # Controlling system-wide privileges
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = ["hyprland"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    ];
  };
}
