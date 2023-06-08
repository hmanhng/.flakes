{ config, lib, pkgs, inputs, user, ... }:
{
  imports = (import ../hardware) ++
    [ ../fonts ];
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
  ];
  programs.dconf.enable = true;
  programs.light.enable = true;
  programs = {
    npm = {
      enable = true;
      npmrc = ''
        prefix = ''${HOME}/.local/share/npm-packages
        cache=''${XDG_CACHE_HOME}/npm
        tmp=''${XDG_RUNTIME_DIR}/npm
        init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
      '';
    };
  };

  services.openssh.enable = true;
  services.dbus = {
    enable = true;
    packages = [ pkgs.gcr ];
  };
  services.gvfs.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.geoclue2.enable = true;

  security.pam.services.swaylock = { };
  security.rtkit.enable = true;
  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland ];
  };
}
