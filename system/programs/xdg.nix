{pkgs, ...}: {
  environment.systemPackages = with pkgs; [xdg-utils];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
