{pkgs, ...}: {
  home.packages = with pkgs; [libnotify];
  services.mako = {
    enable = true;
    settings = {
      font = "Liga CodeNewRoman Nerd Font 12";
      width = "300";
      height = "500";
      margin = "5";
      padding = "5";
      border-size = "2";
      border-radius = "1";
      background-color = "#3A4353E6";
      border-color = "#c0caf5";
      progress-color = "over #D89BE1";
      text-color = "#FAF4FC";
      text-alignment = "center";
      default-timeout = "5000";
      outer-margin = "0, 0, 50, 0";
      layer = "overlay";
    };
    extraConfig = ''
      [urgency=high]
      border-color=#B45C65

      [category=bottom-center]
      anchor=bottom-center
    '';
  };
  xdg.dataFile."icons/svg" = {
    source = ./svg;
    recursive = true;
  };
}
