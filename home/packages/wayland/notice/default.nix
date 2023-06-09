{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    font = "Liga CodeNewRoman Nerd Font 14";
    width = 300;
    height = 500;
    margin = "10";
    padding = "5";
    borderSize = 3;
    borderRadius = 3;
    backgroundColor = "#3A4353";
    borderColor = "#c0caf5";
    progressColor = "over #3B4252";
    textColor = "#FAF4FC";
    defaultTimeout = 5000;
    extraConfig = ''
      text-alignment=center
      [urgency=high]
      border-color=#B45C65
    '';
  };
}
