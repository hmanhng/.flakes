{ config, lib, pkgs, inputs', user, ... }:
{
  imports = (import ./hardware) ++
    [ ./fonts.nix ];

  environment.systemPackages = with pkgs; [
    qt6.qtwayland
  ];
  programs.dconf.enable = true;
  programs.light.enable = true;
  programs.npm = {
    enable = true;
    npmrc = ''
      prefix=''${HOME}/.local/share/npm-packages
      cache=''${XDG_CACHE_HOME}/npm
      init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
    '';
  };
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.openssh.enable = true;
  services.dbus = {
    enable = true;
    packages = [ pkgs.gcr ];
  };
  services.gvfs.enable = true;

  services.geoclue2.enable = true;

  security.pam.services.swaylock = { }; # Pluggable Authentication Modules
  security.rtkit.enable = true; # RealtimeKit
  security.polkit.enable = true; # Controlling system-wide privileges

  xdg.portal = {
    enable = true;
    /* xdgOpenUsePortal = true; */
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      inputs'.hyprland.packages.xdg-desktop-portal-hyprland
    ];
  };
}
