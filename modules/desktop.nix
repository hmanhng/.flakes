{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports =
    (import ./hardware)
    ++ [./fonts.nix];

  environment.systemPackages = with pkgs; [
    qt6.qtwayland
  ];

  hardware.brillo.enable = true;
  programs.dconf.enable = true;
  location.provider = "geoclue2";

  hardware.pulseaudio.enable = lib.mkForce false;

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
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    ];
  };
}
